//
//  GitHubUserProfileService.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/27/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import PromiseKit
import CancellationToken

import Alamofire
import AlamofireObjectMapper


class GitHubUserProfileService {
    
    enum Router: URLRequestConvertible {
        case user(token: String)
        case repositories(token: String)
        
        var path: String {
            switch self {
            case .user(_):
                return "/user"
                
            case .repositories(_):
                return "/user/repos"
            }
        }
        
        var parameters: [String : String] {
            switch self {
                
            case .user(let token):
                return ["access_token":token]
                
            case .repositories(let token):
                return ["access_token":token]
                
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            let url = try GitHubNetworking.defaultNetworking.credentials.baseURL!.asURL()
            let urlRequest = URLRequest(url: url.appendingPathComponent(path))
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        }
    }
    
    fileprivate var accessToken: String!
}

extension GitHubUserProfileService: ProfileNetworkingServiceProtocol {
    
    func prepare(withToken token: String) {
        self.accessToken = token
    }
    
    func fetchUserProfile(cancelltaionToken: CancellationToken?) -> Promise<UserProfileRecord> {
        return Promise { fulfill, reject in
            
            let task = Alamofire.request(Router.user(token: accessToken))
                .validate()
                .responseObject { (response: DataResponse<GHUserEntity>) in
                
                    if let error = response.error {
                        reject(error)
                        return
                    }
                    
                    guard let userEntity = response.result.value else {
                        reject(NSError.cancelledError())
                        return
                    }
                    
                    let profile = UserProfileRecord(userName: userEntity.login,
                                                    avatarUrl: userEntity.avatarUrl,
                                                    publicRepositoriesCount: userEntity.repositories ?? 0,
                                                    followersCount: userEntity.followers ?? 0,
                                                    followingCount: userEntity.following ?? 0)
                    
                    fulfill(profile)
            }
            
            // Perform task cancelation.
            cancelltaionToken?.register {
                task.cancel()
            }
        }
    }
    
    func fetchUserRepositories(cancelltaionToken: CancellationToken?) -> Promise<[RepositoryRecord]> {
        return Promise { fulfill, reject in
            
            let task = Alamofire.request(Router.repositories(token: accessToken))
                .validate()
                .responseArray { (response: DataResponse<[GHRepositoryEntity]>) in
                
                    if let error = response.error {
                        reject(error)
                        return
                    }
                    
                    guard let repositories = response.result.value else {
                        reject(NSError.cancelledError())
                        return
                    }
                
                    // Try to map objects.
                    var page = GHPageEntity<GHRepositoryEntity>()
                    page.items = repositories
                    fulfill(page.repositoryRecordsList())
            }
            
            // Perform task cancelation.
            cancelltaionToken?.register {
                task.cancel()
            }
        }
    }
    
}

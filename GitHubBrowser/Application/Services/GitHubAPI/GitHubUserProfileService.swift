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
        
        var endpoint: String {
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
            let urlRequest = try GitHubNetworking.defaultNetworking.request(forEndpoint: endpoint)
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
                    
                    switch response.result {
                    case .success(let entity):
                        let profile = UserProfileRecord(userEntity: entity)
                        fulfill(profile)
                        
                    case .failure(let error):
                        reject(error)
                    }
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
                
                    switch response.result {
                    case .success(let items):
                        var page = GHPageEntity<GHRepositoryEntity>()
                        page.items = items
                        fulfill(page.repositoryRecordsList())
 
                    case .failure(let error):
                        reject(error)
                    }
            }
            
            // Perform task cancelation.
            cancelltaionToken?.register {
                task.cancel()
            }
        }
    }
}

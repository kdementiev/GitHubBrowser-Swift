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
                
                    guard let error = self.validate(response: response) else {

                        let profile = UserProfileRecord(userEntity:response.value!)
                        fulfill(profile)
                        
                        return
                    }
                    
                    reject(error)
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
                
                    guard let error = self.validate(response: response) else {

                        var page = GHPageEntity<GHRepositoryEntity>()
                        page.items = response.value!
                        fulfill(page.repositoryRecordsList())
                        
                        return
                    }
                    
                    reject(error)
            }
            
            // Perform task cancelation.
            cancelltaionToken?.register {
                task.cancel()
            }
        }
    }
    
    private func validate<T>(response: DataResponse<T>) -> Error? {
        
        if let error = response.error {
            return error
        }
        
        guard let _ = response.result.value else {
            return NSError.cancelledError()
        }
        
        return nil
    }
    
}

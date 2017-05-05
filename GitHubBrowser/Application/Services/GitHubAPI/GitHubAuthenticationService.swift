//
//  GitHubAuthenticationService.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/25/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import PromiseKit
import CancellationToken

import Alamofire
import AlamofireObjectMapper


class GitHubAuthenticationService {
    
    private enum Router: URLRequestConvertible {
        case authorize(otp: String?)
        case deleteKey(id: Int)
        
        var endpoint: String {
            switch self {
                
            case .authorize(_):
                return "/authorizations/clients/\(GitHubNetworking.defaultNetworking.credentials.client)"
                
            case .deleteKey(let id):
                return "/authorizations/\(id)"
            }
        }
        
        var parameters: [String : String] {
            switch self {
            case .authorize(let otp):
                return [
                    "client_secret" : GitHubNetworking.defaultNetworking.credentials.secret,
                    "note" : Bundle.main.bundleIdentifier ?? "",
                    "X-GitHub-OTP" : otp ?? ""
                ]
            case .deleteKey(_):
                return [:]
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            let urlRequest = try GitHubNetworking.defaultNetworking.request(forEndpoint: endpoint)
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
    
    fileprivate func deleteAuthorization(_ authEntity: GHAuthEntity, token: CancellationToken?) -> Promise<GHAuthEntity> {
        return Promise { fulfill, reject in
            
            let task = Alamofire.request(Router.deleteKey(id: authEntity.id!)).response { (response: DefaultDataResponse) in
                if let error = response.error {
                    reject(error)
                    return
                }
                
                fulfill(authEntity)
            }
            
            token?.register {
                task.cancel()
            }
        }
    }
    
    fileprivate func authorize(withCredentials credentials: AuthCredentials, token: CancellationToken?) -> Promise<GHAuthEntity> {
        return Promise { fulfill, reject in
            
            let task = Alamofire.request(Router.authorize(otp: credentials.code))
            
            task.authenticate(user: credentials.username, password: credentials.password)
                .responseObject(completionHandler: { (response: DataResponse<GHAuthEntity>) in
                
                if let _ = response.response?.allHeaderFields["X-GitHub-OTP"] {
                    reject(AuthenticationServiceError.OTPRequired)
                    return
                }
                
                guard let authEntity = response.result.value else {
                    reject(NSError.cancelledError())
                    return
                }
                    
                fulfill(authEntity)
            })
            
            token?.register {
                task.cancel()
            }
        }
    }
}

extension GitHubAuthenticationService: AuthNetworkingServiceProtocol {
    
    func login(withCredentials credentials: AuthCredentials, cancelltaionToken: CancellationToken?) -> Promise<String> {
        return Promise { fulfill, reject in
            
            
            firstly {
                self.authorize(withCredentials: credentials, token: cancelltaionToken)
            }.then { auth -> Promise<GHAuthEntity> in
                
                if (auth.token?.characters.count == 0) {
                    return self.deleteAuthorization(auth, token: cancelltaionToken)
                }

                return Promise<GHAuthEntity>(value: auth)
            }.then { token -> Void in
                fulfill(token.token!)
            }.catch { error in
                reject(error)
            }
            
        }
    }
}










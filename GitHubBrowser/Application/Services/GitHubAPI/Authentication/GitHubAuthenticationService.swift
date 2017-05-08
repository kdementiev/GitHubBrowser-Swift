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
    
    /*
        Headers required by GitHub.
     */
    private struct Headers {
        static let ClientSecret = "client_secret"
        static let Note = "note"
        static let TwoFactorCode = "X-GitHub-OTP"
    }
    
    fileprivate var requiredHeaders = [String : String]()
    
    /*
        Authentication routing.
    */
    private enum Router: URLRequestConvertible {
        
        case authorize(credentials: AuthCredentials)
        case deleteKey(id: Int)
        
        var endpoint: String {
            switch self {
            case .authorize(_):
                return "/authorizations/clients/" + GitHubNetworking.defaultNetworking.credentials.client
                
            case .deleteKey(let id):
                return "/authorizations/\(id)"
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .authorize(_):
                return .put
            case .deleteKey(_):
                return .delete
            }
        }
        
        var parameters: [String : String] {
            switch self {
            case .authorize(let credentials):
                return [
                    Headers.ClientSecret : GitHubNetworking.defaultNetworking.credentials.secret,
                    Headers.Note : Bundle.main.bundleIdentifier ?? "",
                    Headers.TwoFactorCode : credentials.code ?? ""
                ]
                
            case .deleteKey(_):
                return [:]
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            var urlRequest = try GitHubNetworking.defaultNetworking.request(forEndpoint: endpoint)
            urlRequest.httpMethod = method.rawValue
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
    
    fileprivate func deleteAuthorization(_ authEntity: GHAuthEntity, token: CancellationToken?) -> Promise<GHAuthEntity> {
        return Promise { fulfill, reject in
            
            let task = Alamofire.request( Router.deleteKey(id: authEntity.id!))
                .validate()
                .response { (response: DefaultDataResponse) in
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
            
            let task = Alamofire.request(Router.authorize(credentials: credentials))
                .validate()
                .responseObject(completionHandler: { (response: DataResponse<GHAuthEntity>) in
                    
                    if let _ = response.response?.allHeaderFields[Headers.TwoFactorCode] {
                        reject(AuthenticationServiceError.OTPRequired)
                        return
                    }
                    
                    switch response.result {
                    case .success(let authEntity):
                        fulfill(authEntity)
                        
                    case .failure(let error):
                        reject(error)
                    }
                
                })

            token?.register {
                task.cancel()
            }
        }
    }
}

extension GitHubAuthenticationService: AuthNetworkingServiceProtocol {
    
    func login(withCredentials credentials: AuthCredentials, cancelltaionToken: CancellationToken?) -> Promise<String> {
        
        // Use credentials to perform Base Authentication flow using request adapter.
        Alamofire.SessionManager.default.adapter = GitHubAuthenticationRequestAdapter(withCredentials: credentials)
        
        // Provide promise to client
        return Promise { fulfill, reject in

            firstly {
                self.authorize(withCredentials: credentials, token: cancelltaionToken)
            }.then { auth -> Promise<GHAuthEntity> in
                
                if (auth.token?.characters.count == 0) {
                    return self.deleteAuthorization(auth, token: cancelltaionToken).then { auth -> Promise<GHAuthEntity> in
                        self.authorize(withCredentials: credentials, token: cancelltaionToken)
                    }
                }

                return Promise<GHAuthEntity>(value: auth)
            }.then { token -> Void in
                fulfill(token.token!)
            }.catch(on: DispatchQueue.main, policy: .allErrors) { error in
                
                if error is AuthenticationServiceError {
                    reject(error)
                }
                
                reject(error.isCancelledError ? NSError.cancelledError() : AuthenticationServiceError.BadCredentials)
                
            }.always {
                // Clear request adapter to be sure that other requests will be with correct behaviour.
                Alamofire.SessionManager.default.adapter = nil
            }
        }
    }
}










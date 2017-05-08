//
//  GitHubAuthenticationRequestAdapter.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 5/8/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Alamofire

class GitHubAuthenticationRequestAdapter: RequestAdapter {
    
    private var basicAuth: (key: String , value: String)?
    
    init(withCredentials credentials: AuthCredentials) {
        basicAuth = Request.authorizationHeader(user: credentials.username, password: credentials.password)
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        
        var urlRequest = urlRequest
        
        if let basicAuth = basicAuth {
            urlRequest.addValue(basicAuth.value, forHTTPHeaderField: basicAuth.key)
        }
        
        return urlRequest
    }
}

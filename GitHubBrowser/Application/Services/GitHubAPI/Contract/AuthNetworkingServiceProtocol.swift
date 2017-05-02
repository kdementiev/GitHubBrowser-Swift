//
//  AuthNetworkingServiceProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import PromiseKit

struct AuthCredentials {
    
    var username: String
    var password: String
    
    var code: String?
}

enum AuthenticationServiceError: Error {
    case BadCredentials
    case OTPRequired
}

/**  
    Offers interface to interact with remote API to be used in auth way.
 */
protocol AuthNetworkingServiceProtocol {
    
    /**
     Offers simplified way to authenticate user.
     - parameter credentials: AuthCredentials instance.
     - returns: A promise that offers toy handle auth flow events.
     */
    func login(withCredentials credentials: AuthCredentials) -> Promise<String>
}

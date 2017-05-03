//
//  AuthNetworkingServiceProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import PromiseKit
import CancellationToken

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
     - parameter cancelltaionToken: Token helps client with async task cancellation.
     - returns: A promise that offers toy handle auth flow events.
     */
    func login(withCredentials credentials: AuthCredentials, cancelltaionToken: CancellationToken?) -> Promise<String>
}

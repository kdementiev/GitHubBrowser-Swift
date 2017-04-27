//
//  GitHubAuthenticationService.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/25/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import PromiseKit
import Alamofire

class GitHubAuthenticationService: AuthNetworkingServiceProtocol {

    func login(withCredentials credentials: AuthCredentials) -> Promise<String> {
        return Promise { fulfill, reject in
            reject(AuthenticationServiceError.BadCredentials)
        }
    }
}

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


class GitHubAuthenticationService: AuthNetworkingServiceProtocol {

    func login(withCredentials credentials: AuthCredentials, cancelltaionToken: CancellationToken?) -> Promise<String> {
        return Promise { fulfill, reject in
            
            // Perform task cancelation.
            cancelltaionToken?.register {
                reject(NSError.cancelledError())
            }
            
            // TODO: Perform async job.
            
            reject(AuthenticationServiceError.BadCredentials)
        }
        
    }
}

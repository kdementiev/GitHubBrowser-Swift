//
//  GitHubUserProfileService.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/27/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import PromiseKit
import CancellationToken

class GitHubUserProfileService: ProfileNetworkingServiceProtocol {
    
    func prepare(withToken token: String) {
        
    }
    
    func fetchUserProfile(cancelltaionToken: CancellationToken?) -> Promise<UserProfileRecord> {
        return Promise { fulfill, reject in
            
            // Perform task cancelation.
            cancelltaionToken?.register {
                reject(NSError.cancelledError())
            }
            
            reject( NSError(domain: "", code: 1, userInfo: nil) )
        }
    }
    
    func fetchUserRepositories(cancelltaionToken: CancellationToken?) -> Promise<[RepositoryRecord]> {
        return Promise { fulfill, reject in
            
            // Perform task cancelation.
            cancelltaionToken?.register {
                reject(NSError.cancelledError())
            }
            
            reject( NSError(domain: "", code: 1, userInfo: nil) )
        }
    }
}


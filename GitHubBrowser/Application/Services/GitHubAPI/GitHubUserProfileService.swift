//
//  GitHubUserProfileService.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/27/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import PromiseKit

class GitHubUserProfileService: ProfileNetworkingServiceProtocol {
    
    func prepare(withToken token: String) {
        
    }
    
    func fetchUserProfile() -> Promise<UserProfileRecord> {
        return Promise { fulfill, reject in
            reject( NSError(domain: "", code: 1, userInfo: nil) )
        }
    }
    
    func fetchUserRepositories() -> Promise<[RepositoryRecord]> {
        return Promise { fulfill, reject in
            reject( NSError(domain: "", code: 1, userInfo: nil) )
        }
    }
}


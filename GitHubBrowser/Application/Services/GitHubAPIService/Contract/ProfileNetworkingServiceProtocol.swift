//
//  ProfileNetworkingServiceProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation
import PromiseKit

protocol ProfileNetworkingServiceProtocol {
    
    /**
        Offers inerface to prepare with token and handle auth state.
        - parameter token: User Auth2 token.
     */
    func prepare(token: String)
    
    /**
        Offers interface to get user profile from remote server.
        - returns: User profile promise.
     */
    func fetchUserProfile() -> Promise<UserProfileRecord>
    
    /**
        Offers interface to get user repositories from remote server.
        - returns: User repositories list promise.
     */
    func fetchUserRepositories() -> Promise<[RepositoryRecord]>
}

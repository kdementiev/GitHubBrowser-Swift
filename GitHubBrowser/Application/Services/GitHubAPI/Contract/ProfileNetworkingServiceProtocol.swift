//
//  ProfileNetworkingServiceProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation
import PromiseKit

/**
    Offers abstract interface to fetch user profile data from remote server.
 */
protocol ProfileNetworkingServiceProtocol {
    
    /**
        Offers method to prepare with token and handle auth state.
        - parameter token: User Auth2 token.
     */
    func prepare(withToken token: String)
    
    /**
        Offers method to get user profile from remote server.
        - returns: User profile promise.
     */
    func fetchUserProfile() -> Promise<UserProfileRecord>
    
    /**
        Offers method to get user repositories from remote server.
        - returns: User repositories list promise.
     */
    func fetchUserRepositories() -> Promise<[RepositoryRecord]>
}

//
//  ProfileNetworkingServiceProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import PromiseKit
import CancellationToken

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
        - parameter cancelltaionToken: Token helps client with async task cancellation.
        - returns: User profile promise.
     */
    func fetchUserProfile(cancelltaionToken: CancellationToken?) -> Promise<UserProfileRecord>
    
    /**
        Offers method to get user repositories from remote server.
        - parameter cancelltaionToken: Token helps client with async task cancellation.
        - returns: User repositories list promise.
     */
    func fetchUserRepositories(cancelltaionToken: CancellationToken?) -> Promise<[RepositoryRecord]>
}

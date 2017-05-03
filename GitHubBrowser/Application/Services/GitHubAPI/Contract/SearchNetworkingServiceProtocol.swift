//
//  SearchNetworkingServiceProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import PromiseKit
import CancellationToken

/**
    Offers interface to perform search for a specific items via remote server.
 */
protocol SearchNetworkingServiceProtocol {
    
    /**
        Offers method to perform search request to remote server.
        - parameter cancelltaionToken: Token helps client with async task cancellation.
        - parameter text: Search query
     */
    func searchRepositories(withText text: String!, cancelltaionToken: CancellationToken?) -> Promise<[RepositoryRecord]>
}

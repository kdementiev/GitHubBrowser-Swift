//
//  SearchNetworkingServiceProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import PromiseKit

/**
    Offers interface to perform search for a specific items via remote server.
 */
protocol SearchNetworkingServiceProtocol {
    
    /**
        Offers method to perform search request to remote server.
        - parameter text: Search query
     */
    func searchRepositories(withText text: String?) -> Promise<[RepositoryRecord]>
}

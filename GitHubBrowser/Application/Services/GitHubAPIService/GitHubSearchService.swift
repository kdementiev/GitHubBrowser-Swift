//
//  GitHubSearchService.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/27/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import PromiseKit

class GitHubSearchService: SearchNetworkingServiceProtocol {
    
    func searchRepositories(withText text: String?) -> Promise<[RepositoryRecord]> {
        return Promise { fulfill, reject in
            
        }
    }
}

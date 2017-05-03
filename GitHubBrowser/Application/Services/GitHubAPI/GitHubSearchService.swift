//
//  GitHubSearchService.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/27/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import PromiseKit
import CancellationToken

class GitHubSearchService: SearchNetworkingServiceProtocol {
    
    func searchRepositories(withText text: String!, cancelltaionToken: CancellationToken?) -> Promise<[RepositoryRecord]> {

        return Promise { fulfill, reject in
            // Perform task cancelation.
            cancelltaionToken?.register {
                reject(NSError.cancelledError())
            }
            
        }
    }
}

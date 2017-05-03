//
//  LocalStorageServiceProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/26/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import PromiseKit



protocol LocalStorageServiceProtocol: class {
    
    /**
     */
    func saveSearchQuery(_ query: String)
    
    /**
    */
    func fetchSearchQueries() -> Promise<[SearchQueryRecord]>
    
    /**
    */
    func removeQuery(_ query: String)
}

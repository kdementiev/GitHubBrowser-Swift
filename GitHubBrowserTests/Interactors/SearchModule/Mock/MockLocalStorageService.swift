//
//  MockLocalStorageService.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 5/4/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

import PromiseKit
import CancellationToken

@testable import GitHubBrowser


class MockLocalStorageService: LocalStorageServiceProtocol {

    private var queries = [SearchQueryRecord]()
    var error: Error?
    
    func saveSearchQuery(_ query: String) {
        let record = SearchQueryRecord(query: query, date: Date())
        queries.append(record)
    }
    
    func fetchSearchQueries() -> Promise<[SearchQueryRecord]> {
        
        return Promise { fulfill, reject in
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1), execute: {
                
                if let error = self.error {
                    reject(error)
                    return
                }
                
                fulfill(self.queries)
            })
        }
    }
    
    func removeQuery(_ query: String) {
        
        let position = queries.index { (element) -> Bool in
            return element.query == query
        }
        
        if let position = position {
            queries.remove(at: position)
        }
    }
}

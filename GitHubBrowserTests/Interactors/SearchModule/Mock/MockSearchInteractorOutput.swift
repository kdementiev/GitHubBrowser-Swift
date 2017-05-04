//
//  MockSearchInteractorOutput.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 5/4/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

import PromiseKit
import CancellationToken

@testable import GitHubBrowser


class MockSearchInteractorOutput {
    
    fileprivate var historyFetchedBlock: (([SearchQueryRecord]) -> Void)?
    fileprivate var searchReceivedBlock: (([RepositoryRecord]) -> Void)?
    
    
    init(history: (([SearchQueryRecord]) -> Void)?, search: (([RepositoryRecord]) -> Void)? ) {
        historyFetchedBlock = history
        searchReceivedBlock = search
    }
}

extension MockSearchInteractorOutput: SearchInteractorOutput {
    
    func searchHistoryFetched(_ list: [SearchQueryRecord]!) {
        if let block = historyFetchedBlock {
            block(list)
        }
    }
    
    func searchResultsReceived(_ repositories: [RepositoryRecord]!) {
        if let block = searchReceivedBlock {
            block(repositories)
        }
    }
}

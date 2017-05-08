//
//  SearchInteractor.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import PromiseKit
import CancellationToken

class SearchInteractor: SearchInteractorProtocol {
    var output: SearchInteractorOutput?
    
    var searchNetworking: SearchNetworkingServiceProtocol!
    var historyStorage: LocalStorageServiceProtocol!
    
    lazy var searchTokenSource: CancellationTokenSource? = CancellationTokenSource()
    
    func prepare() {
    }
    
    func fetchSearchHistory() {
        
        firstly {
            historyStorage.fetchSearchQueries()
        }.then { queries -> Void in
            self.output?.searchHistoryFetched(queries)
        }.catch { _ in
            // Do nothing.
        }
    }
    
    func searchRepositories(text: String!) {
        
        self.cancelSearch()
        
        firstly {
            searchNetworking.searchRepositories(withText: text, cancelltaionToken: searchTokenSource?.token)
        }.then { repositories -> Void in
            self.output?.searchResultsReceived(repositories)
        }.always {
            self.historyStorage.saveSearchQuery(text)
        }
    }
    
    func cancelSearch() {
        searchTokenSource?.cancel()
        searchTokenSource = nil
    }
}

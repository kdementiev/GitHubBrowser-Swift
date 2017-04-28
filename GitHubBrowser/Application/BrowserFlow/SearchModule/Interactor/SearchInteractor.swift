//
//  SearchInteractor.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import PromiseKit

class SearchInteractor: SearchInteractorProtocol {
    var output: SearchInteractorOutput?
    
    var searchNetworking: SearchNetworkingServiceProtocol!
    var historyStorage: LocalStorageServiceProtocol!
    
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
        
        firstly {
            searchNetworking.searchRepositories(withText: text)
        }.then { repositories -> Void in
            self.output?.searchResultsReceived(repositories)
        }.catch { _ in
            
        }
        
        historyStorage.saveSearchQuery(text)
    }
    
    func cancelSearch() {
        
    }
}

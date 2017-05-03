//
//  SearchPresenter.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

class SearchPresenter: SearchPresenterProtocol {
    
    weak var view: SearchViewProtocol?
    
    var interactor: SearchInteractorProtocol?
    var router: SearchRouterProtocol?
    
    var moduleOutput: SearchModuleOutputProtocol?
    
    // MARK: - View Layer Feedback -
    
    func viewReadyForInteraction() {
        
        // Forward event to interactor
        interactor?.fetchSearchHistory()
    }
    
    func userWantsToSearch(text: String!) {
        // Execute search
        interactor?.searchRepositories(text: text)
        
        // Move view to activity state
        view?.showActivity()
    }
    
    func userWantsToCancelSearch() {
        
        // Force search cancelation.
        interactor?.cancelSearch()
        
        // Request search history to be shown insted of activity state.
        interactor?.fetchSearchHistory()
    }
    
    // MARK: - Interactor Layer Feedback -
    
    func searchHistoryFetched(_ list:[SearchQueryRecord]!) {
        
        if list.count == 0 {
            view?.showEmptyState()
            return
        }
        
        view?.showSearchHistory(list)
    }
    
    func searchResultsReceived(_ repositories:[RepositoryRecord]!) {
        
        if repositories.count == 0 {
            view?.showNotFoundState()
            return
        }
        
        view?.showSearchResults(repositories)
        
    }
}

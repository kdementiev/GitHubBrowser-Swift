//
//  SearchInteractorProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

protocol SearchInteractorOutput: class {

    func searchHistoryFetched(_ list:[SearchQueryRecord]!)
    func searchResultsReceived(_ repositories:[RepositoryRecord]!)
}

protocol SearchInteractorProtocol: class {
    
    weak var output: SearchInteractorOutput? { get set }
    
    /**
        Method offered to perform initial preparations inside interactor.
     */
    func prepare()
    
    func fetchSearchHistory()
    func searchRepositories(text: String!)
    func cancelSearch()
    
}

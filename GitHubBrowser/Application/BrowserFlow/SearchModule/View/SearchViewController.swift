//
//  SearchViewController.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var output: SearchViewOutput?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Notify presenter layer with ready state.
        self.output?.viewReadyForInteraction()
    }
    
    // MARK: - Notification Helpers -
    
    fileprivate func notifyWithUserWantsToSearch(query: String?) {
    
        // Notify Presentation layer with user input.
        output?.userWantsToSearch(text: query)
        
        // Get focus out of Search Bar.
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController: SearchViewProtocol {
    
    func showEmptyState() {
        tableView.contentProvider = nil
    }
    
    func showNotFoundState() {
        tableView.contentProvider = NotFoundStateDataProvider()
    }
    
    func showSearchHistory(_ list:[SearchQueryRecord]!) {
        tableView.contentProvider = SearchHistoryDataProvider(queries: list, delegate: self)
    }
    
    func showSearchResults(_ repositories:[RepositoryRecord]!) {
        tableView.contentProvider = SearchRepositoriesDataProvider(repositories: repositories)
    }
    
    func showActivity() {
        tableView.contentProvider = ActivityStateDataProvider()
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // Process search action
        self.notifyWithUserWantsToSearch(query: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        // Notify with cancel.
        output?.userWantsToCancelSearch()
        
        // Go out from search bar input field.
        searchBar.resignFirstResponder()
        searchBar.text = nil
    }
}

extension SearchViewController: SearchHistoryDataProviderDelegate {
    
    func onSearchQuerySelected(_ query: String?) {
        
        // Put chosed query to Search Bar text inpit.
        searchBar.text = query
        
        // Process search action
        self.notifyWithUserWantsToSearch(query: query)
    }
}

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Notify presenter layer with ready state.
        self.output?.viewReadyForInteraction()
    }
}

extension SearchViewController: SearchViewProtocol {
    
    func showEmptyState() {
        
    }
    
    func showNotFoundState() {
        
    }
    
    func showSearchHistory(_ list:[String]!) {
        
    }
    
    func showSearchResults(_ repositories:[RepositoryRecord]!) {
        
    }
    
    func showActivity() {
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    
}

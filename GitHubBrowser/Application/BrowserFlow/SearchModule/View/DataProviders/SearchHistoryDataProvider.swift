//
//  SearchHistoryDataProvider.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/27/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit


protocol SearchHistoryDataProviderDelegate: class {
    
    func onSearchQuerySelected(_ query: String?)
}


class SearchHistoryDataProvider: NSObject {
    
    weak var delegate: SearchHistoryDataProviderDelegate?
    
    fileprivate var queries: [String]!
    
    init(queries: [String], delegate: SearchHistoryDataProviderDelegate?) {
        self.delegate = delegate
        self.queries = queries
    }
}

extension SearchHistoryDataProvider: TableViewDataProvider {
    
    func prepare(tableView: UITableView!) {
    }
}

extension SearchHistoryDataProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recent search:".localized()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return queries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let queryCell = QueryTableViewCell.reusableCell(tableView: tableView)!;
        queryCell.textLabel?.text = queries[indexPath.row]
        return queryCell;
    }
}

extension SearchHistoryDataProvider: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let searchQuery = queries[indexPath.row]
        delegate?.onSearchQuerySelected(searchQuery)
    }
}

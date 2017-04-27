//
//  RepositoriesDataProvider.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class RepositoriesDataProvider: NSObject {
    
    fileprivate let CellEstimatedHeight: CGFloat = 82
    
    fileprivate var repositories: [RepositoryRecord]?
    
    init(repositories: [RepositoryRecord]?) {
        self.repositories = repositories
    }
    
    deinit {
        NSLog("RepositoriesDataProvider die.")
    }
}

extension RepositoriesDataProvider: TableViewDataProvider {
    
    func prepare(tableView: UITableView!) {
        // We need to register our cell.
        RepositoryTableViewCell.registerCell(tableView: tableView)
        
        // Prepare auto-sized cells.
        tableView.estimatedRowHeight = CellEstimatedHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}

extension RepositoriesDataProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RepositoryTableViewCell.reusableCell(tableView: tableView)
        
        // TODO: Perform cell setting-up.
        
        return cell!;
    }
}

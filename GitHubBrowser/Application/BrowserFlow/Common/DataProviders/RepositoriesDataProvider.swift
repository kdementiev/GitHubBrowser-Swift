//
//  RepositoriesDataProvider.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class RepositoriesDataProvider: NSObject, TableViewDataProvider {
    
    private var repositories: [RepositoryRecord]?
    
    init(repositories: [RepositoryRecord]?) {
        self.repositories = repositories
    }
    
    func prepare(tableView: UITableView!) {
        RepositoryTableViewCell.registerCell(tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RepositoryTableViewCell.reusableCell(tableView: tableView)
        
        return cell!;
    }
    
    deinit {
        NSLog("RepositoriesDataProvider die.")
    }
    
}

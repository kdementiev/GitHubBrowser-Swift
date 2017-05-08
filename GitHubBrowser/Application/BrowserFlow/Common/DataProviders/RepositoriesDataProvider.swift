//
//  RepositoriesDataProvider.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class RepositoriesDataProvider: NSObject {
    
    static let CellEstimatedHeight: CGFloat = 82
    
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
    }
}

extension RepositoriesDataProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let repository = self.repositories?[indexPath.row]
        let cell = RepositoryTableViewCell.reusableCell(tableView: tableView)
        
        // TODO: Perform cell setting-up.
        cell?.setColorPosition( CGFloat(indexPath.row + 1) / CGFloat(repositories?.count ?? 0))
        
        cell?.titleLabel.text = repository?.name
        cell?.descriptionLabel.text = repository?.description ?? "No description.".localized()
        cell?.languageLabel.text = repository?.language
        cell?.authorLabel.text = repository?.ownerName
        
        cell?.starsLabel.text = "\(repository?.starsCount ?? 0)"
        
        return cell!;
    }
}

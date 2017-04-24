//
//  NoContentStateDataProvider.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class NoContentStateDataProvider: NSObject, TableViewDataProvider {

    func prepare(tableView: UITableView!) {
    }
    
    // MARK - UITableViewDataSource -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return NoContentTableViewCell.reusableCell(tableView: tableView)!
    }

}

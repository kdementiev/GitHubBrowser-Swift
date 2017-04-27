//
//  NotFoundStateDataProvider.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/27/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class NotFoundStateDataProvider: NSObject {
    
    fileprivate static let NothingFoundTableViewCellIdentifier = "NothingFoundTableViewCell"
}

extension NotFoundStateDataProvider: TableViewDataProvider {
    
    func prepare(tableView: UITableView!) {
    }
}

extension NotFoundStateDataProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: NotFoundStateDataProvider.NothingFoundTableViewCellIdentifier)!;
    }
}

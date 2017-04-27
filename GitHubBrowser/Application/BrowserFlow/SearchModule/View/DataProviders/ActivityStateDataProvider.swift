//
//  ActivityStateDataProvider.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/27/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class ActivityStateDataProvider: NSObject {

}

extension ActivityStateDataProvider: TableViewDataProvider {
    
    func prepare(tableView: UITableView!) {
    }
}

extension ActivityStateDataProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return ActivityTableViewCell.reusableCell(tableView: tableView)!;
    }
}

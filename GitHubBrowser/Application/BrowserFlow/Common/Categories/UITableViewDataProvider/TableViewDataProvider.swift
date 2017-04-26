//
//  TableViewDataProvider.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

protocol TableViewDataProvider: UITableViewDelegate, UITableViewDataSource {

    /**
        Offers event to prepare custom data provider.
     */
    func prepare(tableView: UITableView!)
    
}

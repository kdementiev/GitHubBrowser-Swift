//
//  UITableViewCellUsabilityExtension.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    func registerCell(tableView: UITableView) {
        tableView.register(self.classForCoder, forCellReuseIdentifier: String(describing: self))
    }
    
    func reusableCell<T>(tableView: UITableView) -> T? {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: self)) as? T
    }
}


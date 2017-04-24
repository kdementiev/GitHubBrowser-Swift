//
//  UITableViewCell+Usability.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    class func registerCell(tableView: UITableView) {
        let className = String(describing: self)
        tableView.register(self.classForCoder(), forCellReuseIdentifier: className)
    }
    
    class func reusableCell(tableView: UITableView) -> Self? {
        return reusableCell(type:self, tableView: tableView)
    }
    
    private class func reusableCell<T>(type: T.Type, tableView: UITableView) -> T? {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: self)) as? T
    }
}


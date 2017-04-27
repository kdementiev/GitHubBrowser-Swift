//
//  UnauthorizedStateDataProvider.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

protocol UnauthorizedStateDataProviderDelegate: class {
    func onSignInAction()
}

class UnauthorizedStateDataProvider: NSObject, TableViewDataProvider {
    
    weak var delegate: UnauthorizedStateDataProviderDelegate?
    
    init(delegate: UnauthorizedStateDataProviderDelegate?) {
        self.delegate = delegate
    }
    
    func prepare(tableView: UITableView!) {
    }
}

extension UnauthorizedStateDataProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UnauthorizedTableViewCell.reusableCell(tableView: tableView)
        
        cell?.signInCallback = { [weak self] in
            self?.delegate?.onSignInAction()
        }
        
        return cell!;
    }
    
}

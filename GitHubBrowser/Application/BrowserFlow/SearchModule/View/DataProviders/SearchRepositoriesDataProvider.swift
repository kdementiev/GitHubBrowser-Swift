//
//  SearchRepositoriesDataProvider.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/27/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit
import Localize_Swift

class SearchRepositoriesDataProvider: RepositoriesDataProvider {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search results:".localized()
    }
    
    deinit {
        NSLog("SearchRepositoriesDataProvider die.")
    }
}

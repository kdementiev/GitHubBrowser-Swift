//
//  SearchViewController.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    
    var output: SearchViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Notify presenter layer with ready state.
        self.output?.viewReadyForInteraction()
    }


}

extension SearchViewController: SearchViewProtocol {
    
}

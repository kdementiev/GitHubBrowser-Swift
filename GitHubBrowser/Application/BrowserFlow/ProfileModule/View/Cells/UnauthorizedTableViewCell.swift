//
//  UnauthorizedTableViewCell.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

typealias UnauthorizedCellSignInAction = () -> Void

class UnauthorizedTableViewCell: UITableViewCell {
    
    var signInCallback: UnauthorizedCellSignInAction?

    @IBAction func onSignInAction(_ sender: Any) {
        if signInCallback != nil {
            self.signInCallback!()
        }
    }
}

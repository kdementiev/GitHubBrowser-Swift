//
//  ActivityTableViewCell.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/27/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Start activity animation.
        activityIndicator.startAnimating()
    }

}

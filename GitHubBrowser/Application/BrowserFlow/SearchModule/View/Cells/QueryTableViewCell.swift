//
//  QueryTableViewCell.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/27/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class QueryTableViewCell: UITableViewCell {

    @IBInspectable var selectionColor: UIColor?
    
    @IBOutlet weak var queryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        self.selectedBackgroundView = UIView()
        self.selectedBackgroundView?.backgroundColor = selectionColor
    }
}

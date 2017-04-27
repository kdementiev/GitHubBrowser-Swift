//
//  QueryTableViewCell.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/27/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class QueryTableViewCell: UITableViewCell {

    @IBOutlet weak var queryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

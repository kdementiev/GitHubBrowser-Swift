//
//  RepositoryTableViewCell.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        UIView .animate(withDuration: 1) { 
            self.alpha = highlighted ? 0.5 : 1.0
        }
    }
    
    func setColorPosition(_ position: CGFloat) {
        
    }
}

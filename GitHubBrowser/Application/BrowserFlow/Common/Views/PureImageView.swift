//
//  PureImageView.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class PureImageView: UIImageView {

    @IBInspectable var placeholder: UIImage? {
        didSet {
            self.applyPlaceholder()
        }
    }

    override var image: UIImage? {
        didSet {
            self.applyPlaceholder()
        }
    }
    
    private func applyPlaceholder() {
        if image == nil {
            image = placeholder
        }
    }
}

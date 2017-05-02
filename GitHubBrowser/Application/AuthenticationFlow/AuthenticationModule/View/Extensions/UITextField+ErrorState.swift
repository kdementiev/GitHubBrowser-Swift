//
//  UITextField+ErrorState.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/26/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

extension UITextField {
    
    func showError(_ show: Bool) {
        self.layer.borderColor = show ? UIColor.red.cgColor : UIColor.clear.cgColor
        self.layer.borderWidth = 1
    }
}

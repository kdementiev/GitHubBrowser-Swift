//
//  UIAlertController+ProfileAlerts.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

import Localize_Swift

extension UIAlertController {
    
    /**
        Offers ability to create fully prepared SignOut alert instance.
    */
    class func alertControllerForSignOut(accept: (@escaping () -> Void) ) -> UIAlertController {
        
        // Prepare actions
        
        let signOutAction = UIAlertAction(title: "YES".localized(), style: .destructive) { (action) in
            accept()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        
        
        // Prepare alert controller
        
        let title = "SIGN-OUT".localized()
        let message = "Are you sure you want to Sign-Out?".localized()
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(signOutAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
}

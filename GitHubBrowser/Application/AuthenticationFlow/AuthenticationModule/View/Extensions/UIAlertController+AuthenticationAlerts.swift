//
//  UIAlertController+AuthenticationAlerts.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/26/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit
import Localize_Swift

typealias UIAlertControllerTwoFactorCodeCallback = (_ code: String?) -> Void

extension UIAlertController {

    class func twoFactorAlert(doneHandler: @escaping UIAlertControllerTwoFactorCodeCallback) -> UIAlertController {
    
        // Prepare localizations for alert.
        let title = "Two-Factor Auth".localized()
        let message = "Obtain code from SMS or Application.".localized()
        
        // Configurate alert.
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField { (textField: UITextField) in
            textField.placeholder = "Code".localized()
            
            textField.borderStyle = .none
            textField.clearButtonMode = .whileEditing
        }
        
        // Prepare sign-in action to allow user continue after otp code was provided.
        let signInAction = UIAlertAction(title: "SIGN-IN".localized(), style: .default) { (action) in
            let otpCode = alertController.textFields?.first?.text
            doneHandler(otpCode)
        }
        
        alertController.addAction(signInAction)
        
        return alertController
    }
    
    class func authErrorAlert(message: String?) -> UIAlertController {
        
        let title = "Authentication Error".localized()
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK".localized(), style: .cancel, handler: nil)
        alertController.addAction(okAction)
        
        return alertController
    }

}

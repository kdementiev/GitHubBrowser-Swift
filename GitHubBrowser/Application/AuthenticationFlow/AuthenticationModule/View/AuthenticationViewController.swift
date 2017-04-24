//
//  AuthenticationViewController.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var output: AuthenticationViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Notify presenter layer with ready state.
        self.output?.viewReadyForInteraction()
    }

    @IBAction func onTapAction(_ sender: Any) {
        
    }
    
    @IBAction func onSignInAction(_ sender: Any) {
        
    }
    
    @IBAction func onNoAccountAction(_ sender: Any) {
        
    }
    
    @IBAction func onCancelAction(_ sender: Any) {
        
    }
}

extension AuthenticationViewController: AuthenticationViewProtocol {
    
}

extension AuthenticationViewController: UITextFieldDelegate {
    
}

//
//  AuthenticationRouter.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class AuthenticationRouter: AuthenticationRouterProtocol {
    weak var viewController: UIViewController?
    
    private static let GitHubCreateAccountLink = "https://github.com/join?source=login"
    
    func navigateToCreateAccount() {
        
        guard let targetURL = URL(string: AuthenticationRouter.GitHubCreateAccountLink) else {
            return;
        }
        
        UIApplication.shared.open(targetURL, options: [:], completionHandler: nil)
    }
    
    func navigateBack() {
        viewController?.navigationController?.dismiss(animated: true, completion: nil)
    }
}

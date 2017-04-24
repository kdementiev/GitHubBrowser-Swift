//
//  ProfileRouter.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit
import PrettySegue

class ProfileRouter: ProfileRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToAuthenticationScreen(delegate: AuthenticationModuleOutputProtocol?) {
        
        viewController?.performSegue(withIdentifier: "AuthenticationFlowSegue", sender: self) { (controller: UIViewController?) -> (Void) in
            
            guard let navigationController = controller as? UINavigationController else {
                assertionFailure("Invalid destinational controller. Must be UINavigationController")
                return
            }
            
            guard let view = navigationController.topViewController as? AuthenticationViewProtocol else {
                assertionFailure("Module view must conforms to AuthenticationViewProtocol protocol")
                return
            }
            
            AuthenticationModuleConfigurator.configurateModule(view: view, delegate: delegate)
            
        }
    }
}

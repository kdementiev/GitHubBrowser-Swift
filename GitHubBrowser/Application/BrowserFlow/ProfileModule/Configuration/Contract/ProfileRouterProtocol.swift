//
//  ProfileRouterProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

protocol ProfileRouterProtocol: class {
    
    /*
     Offers ability to navigate to AuthorizationModule and handle its actions.
    */
    func navigateToAuthenticationScreen(delegate: AuthenticationModuleOutputProtocol?);
}

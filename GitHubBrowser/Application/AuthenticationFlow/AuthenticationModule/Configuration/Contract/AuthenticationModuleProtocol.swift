//
//  AuthenticationModuleProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

protocol AuthenticationModuleInputProtocol: class {
    
}

protocol AuthenticationModuleOutputProtocol: class {
    
    /**
        Called to notify other module with user authorization flow done well event.
    */
    func userSuccessfullySignedIn()
}

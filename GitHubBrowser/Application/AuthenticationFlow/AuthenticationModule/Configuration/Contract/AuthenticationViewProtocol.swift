//
//  AuthenticationViewProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

protocol AuthenticationViewOutput: class {
    
    /**
        Called when view loaded and ready for data.
    */
    func viewReadyForInteraction()
}

protocol AuthenticationViewProtocol: class {
    var output: AuthenticationViewOutput? { get set }
    
}

//
//  ProfileViewProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

protocol ProfileViewOutput: class {
    
    /**
        Called when view loaded and ready for data.
    */
    func viewReadyForInteraction()
}

protocol ProfileViewProtocol: class {
    var output: ProfileViewOutput? { get set }
    
}

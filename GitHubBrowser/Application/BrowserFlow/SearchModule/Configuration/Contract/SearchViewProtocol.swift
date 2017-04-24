//
//  SearchViewProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

protocol SearchViewOutput: class {
    
    /**
        Called when view loaded and ready for data.
    */
    func viewReadyForInteraction()
}

protocol SearchViewProtocol: class {
    var output: SearchViewOutput? { get set }
    
}

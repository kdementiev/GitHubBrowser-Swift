//
//  SearchInteractorProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

protocol SearchInteractorOutput: class {
    
}

protocol SearchInteractorProtocol: class {
    weak var output: SearchInteractorOutput? { get set }
    
    /**
        Method offered to perform initial preparations inside interactor.
     */
    func prepare()
}

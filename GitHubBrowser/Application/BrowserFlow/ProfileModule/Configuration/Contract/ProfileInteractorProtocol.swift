//
//  ProfileInteractorProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

protocol ProfileInteractorOutput: class {
    
}

protocol ProfileInteractorProtocol: class {
    weak var output: ProfileInteractorOutput? { get set }
    
    /**
        Method offered to perform initial preparations inside interactor.
     */
    func prepare()
}

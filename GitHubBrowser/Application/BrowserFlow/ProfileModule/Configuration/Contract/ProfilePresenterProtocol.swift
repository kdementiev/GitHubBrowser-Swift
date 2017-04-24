//
//  ProfilePresenterProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

protocol ProfilePresenterProtocol: ProfileViewOutput, ProfileInteractorOutput, ProfileModuleInputProtocol {
    
    weak var view: ProfileViewProtocol? { get set }
    
    var interactor: ProfileInteractorProtocol? { get set }
    var router: ProfileRouterProtocol? { get set }
    
    var moduleOutput: ProfileModuleOutputProtocol? { get set }
}

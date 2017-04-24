//
//  AuthenticationPresenterProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

protocol AuthenticationPresenterProtocol: AuthenticationViewOutput, AuthenticationInteractorOutput, AuthenticationModuleInputProtocol {
    
    weak var view: AuthenticationViewProtocol? { get set }
    
    var interactor: AuthenticationInteractorProtocol? { get set }
    var router: AuthenticationRouterProtocol? { get set }
    
    var moduleOutput: AuthenticationModuleOutputProtocol? { get set }
}

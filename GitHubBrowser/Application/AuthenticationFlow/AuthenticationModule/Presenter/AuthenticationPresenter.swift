//
//  AuthenticationPresenter.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

class AuthenticationPresenter: AuthenticationPresenterProtocol {
    
    weak var view: AuthenticationViewProtocol?
    
    var interactor: AuthenticationInteractorProtocol?
    var router: AuthenticationRouterProtocol?
    
    var moduleOutput: AuthenticationModuleOutputProtocol?
    
    
    func viewReadyForInteraction() {
        
        // Forward event to interactor
        interactor?.prepare()
    }
}

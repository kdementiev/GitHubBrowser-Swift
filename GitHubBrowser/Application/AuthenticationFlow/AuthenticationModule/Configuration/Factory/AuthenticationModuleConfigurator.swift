//
//  AuthenticationModuleConfigurator.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class AuthenticationModuleConfigurator {
    
    @discardableResult
    static func configurateModule(view: AuthenticationViewProtocol?, delegate: AuthenticationModuleOutputProtocol?) -> (view: UIViewController?, module: AuthenticationModuleInputProtocol?) {
        
        assert(view != nil, "Please, provide view instance.")
        
        let interactor = AuthenticationInteractor()
        let presenter = AuthenticationPresenter()
        let router = AuthenticationRouter()
        
        view?.output = presenter
        
        interactor.output = presenter
        interactor.authService = GitHubAuthenticationService()
        interactor.tokenStorage = SecureStorageService.sharedInstance
        interactor.credentialsValidator = GitHubCredentialsValidator()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        presenter.moduleOutput = delegate
        
        router.viewController = view as? UIViewController
        
        return (router.viewController, presenter)
    }
}


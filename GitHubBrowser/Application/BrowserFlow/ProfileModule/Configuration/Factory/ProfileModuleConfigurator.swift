//
//  ProfileModuleConfigurator.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class ProfileModuleConfigurator {
    
    static func configurateModule(view: ProfileViewProtocol?, delegate: ProfileModuleOutputProtocol?)
        -> (view: UIViewController?, module: ProfileModuleInputProtocol?) {
        
        assert(view != nil, "Please, provide view instance.")
        
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
        
        view?.output = presenter
        
        interactor.output = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        presenter.moduleOutput = delegate
        
        router.viewController = view as? UIViewController
        
        return (router.viewController, presenter)
    }
}


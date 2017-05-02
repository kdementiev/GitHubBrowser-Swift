//
//  SearchModuleConfigurator.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

class SearchModuleConfigurator {
    
    static func configurateModule(view: SearchViewProtocol?, delegate: SearchModuleOutputProtocol?) -> (view: UIViewController?, module: SearchModuleInputProtocol?) {
        
        assert(view != nil, "Please, provide view instance.")
        
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        
        view?.output = presenter
        
        interactor.output = presenter
        interactor.searchNetworking = GitHubSearchService()
        interactor.historyStorage = LocalStorageService.sharedInstance
  
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        presenter.moduleOutput = delegate
        
        router.viewController = view as? UIViewController
        
        return (router.viewController, presenter)
    }
}


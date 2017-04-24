//
//  SearchPresenter.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

class SearchPresenter: SearchPresenterProtocol {
    
    weak var view: SearchViewProtocol?
    
    var interactor: SearchInteractorProtocol?
    var router: SearchRouterProtocol?
    
    var moduleOutput: SearchModuleOutputProtocol?
    
    
    func viewReadyForInteraction() {
        
        // Forward event to interactor
        interactor?.prepare()
    }
}

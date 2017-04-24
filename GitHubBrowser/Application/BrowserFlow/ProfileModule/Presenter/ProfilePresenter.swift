//
//  ProfilePresenter.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var view: ProfileViewProtocol?
    
    var interactor: ProfileInteractorProtocol?
    var router: ProfileRouterProtocol?
    
    var moduleOutput: ProfileModuleOutputProtocol?
    
    
    func viewReadyForInteraction() {
        
        // Forward event to interactor
        interactor?.prepare()
    }
}

//
//  SearchPresenterProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

protocol SearchPresenterProtocol: SearchViewOutput, SearchInteractorOutput, SearchModuleInputProtocol {
    
    weak var view: SearchViewProtocol? { get set }
    
    var interactor: SearchInteractorProtocol? { get set }
    var router: SearchRouterProtocol? { get set }
    
    var moduleOutput: SearchModuleOutputProtocol? { get set }
}

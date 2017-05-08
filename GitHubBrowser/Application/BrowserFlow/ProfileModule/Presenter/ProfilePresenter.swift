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
    
    // MARK: - View Layer Feedback -
    
    func viewReadyForInteraction() {
        
        // Forward event to interactor
        interactor?.prepare()
    }
    
    func userWantsToSignIn() {
        router?.navigateToAuthenticationScreen(delegate: self)
    }
    
    func userWantsToSignOut() {
        view?.showSignOutAlert()
    }
    
    func userDidAcceptSignOut() {
        interactor?.performSignOut()
    }
    
    func userWantsLatestData() {
        interactor?.fetchData()
    }

    // MARK: - Interactor Layer Feedback
    
    func userAuthorized() {
        // Ask view to show 'No Content' state
        view?.showNoContentState()
        
        // Show activity state.
        view?.showActivity()
    }
    
    func userNotAuthorized() {
        view?.showUnauthorizedState()
        view?.hideActivity()
    }
    
    func userProfileReveived(_ profile: UserProfileRecord) {
        view?.showUserProfile(profile)
    }
    
    func userRepositoriesReceived(_ repositories:[RepositoryRecord]?) {
        view?.showRepositories(repositories)
        view?.hideActivity()
    }
}

extension ProfilePresenter: AuthenticationModuleOutputProtocol {
    
    func userSuccessfullySignedIn() {
        
        // Fetch data for new user.
        interactor?.prepare()
    }
}

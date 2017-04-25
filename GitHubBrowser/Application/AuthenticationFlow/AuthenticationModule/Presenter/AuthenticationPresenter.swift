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
    
    // MARK: - View Layer Feedback -
    
    func viewReadyForInteraction() {
        
        // Forward event to interactor
        interactor?.prepare()
    }
    
    func userWantsToLogin(username: String?, password: String?) {
        
        // Put view to activity state to discard all user interactions.
        view?.showActivityState(true)
        
        // Try to login with provided credentials.
        interactor?.login(username: username, password: password)
    }
    
    func userProvidesTwoFactorCode(_ code: String?) {
        //
        view?.showActivityState(true)
        
        // Continue login with two-factor code.
        interactor?.login(code: code)
    }
    
    func userWantsToCreateAccount() {
        router?.navigateToCreateAccount()
    }
    
    func userWantsToCancel() {
        router?.navigateBack()
    }
    
    // MARK: - Interactor Layer Feedback -
    
    func twoFactorAuthenticationRequired() {
        view?.showTwoFactorCodeInput()
    }
    
    func invalidUserName() {
        view?.showActivityState(false)
        view?.showUserNameError()
    }
    
    func invalidUserPassword() {
        view?.showActivityState(false)
        view?.showPasswordError()
    }
    
    func invalidTwoFactorCode() {
        view?.showActivityState(false)
        view?.showInvalidTwoFactorCodeMessage()
    }
    
    func authenticationSuccessfullyPassed() {
        // Notify with successfully signed-in.
        moduleOutput?.userSuccessfullySignedIn()
        
        // Our job done, go back to profile.
        router?.navigateBack()
    }
    
    func authenticationFailedWithBadCredentials() {
        view?.showActivityState(false)
        view?.showInvalidCredentialsMessage()
    }
}


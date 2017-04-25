//
//  AuthenticationViewProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

protocol AuthenticationViewOutput: class {
    
    /**
        Called when view loaded and ready for data.
    */
    func viewReadyForInteraction()

    func userWantsToLogin(username: String?, password: String?)
    func userProvidesTwoFactorCode(_ code: String?)
    
    func userWantsToCreateAccount()
    func userWantsToCancel()
    
}

protocol AuthenticationViewProtocol: class {
    var output: AuthenticationViewOutput? { get set }
    
    func showActivityState(_ show: Bool)
    
    func showInvalidCredentialsMessage()
    func showInvalidTwoFactorCodeMessage()
    
    func showUserNameError()
    func showPasswordError()
    
    func showTwoFactorCodeInput()
    
}

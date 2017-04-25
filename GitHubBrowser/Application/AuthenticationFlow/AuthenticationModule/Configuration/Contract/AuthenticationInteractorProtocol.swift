//
//  AuthenticationInteractorProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

protocol AuthenticationInteractorOutput: class {

    func twoFactorAuthenticationRequired()
    
    func invalidUserName()
    func invalidUserPassword()
    func invalidTwoFactorCode()
    
    func authenticationSuccessfullyPassed()
    func authenticationFailedWithBadCredentials()
    
}

protocol AuthenticationInteractorProtocol: class {
    weak var output: AuthenticationInteractorOutput? { get set }
    
    /**
        Method offered to perform initial preparations inside interactor.
     */
    func prepare()

    func login(username: String?, password:String?)
    func login(code: String?)
}

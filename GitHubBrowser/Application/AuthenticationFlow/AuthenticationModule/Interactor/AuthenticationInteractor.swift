//
//  AuthenticationInteractor.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/22/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import PromiseKit

class AuthenticationInteractor: AuthenticationInteractorProtocol {
    
    var output: AuthenticationInteractorOutput?
    
    // Used services
    var authService: AuthNetworkingServiceProtocol?
    var tokenStorage: TokenStorageServiceProtocol?
    var credentialsValidator: CredentialsValidatorProtocol?
    
    private var authCredentials: AuthCredentials!
    
    func prepare() {
    }
    
    func login(username: String?, password:String?) {
        
        guard credentialsValidator!.validate(username: username) else {
            output?.invalidUserName()
            return
        }
        
        guard credentialsValidator!.validate(password: password) else {
            output?.invalidUserPassword()
            return
        }
        
        // Create local credentials. If credentials validated, map it to objects.
        self.authCredentials = AuthCredentials(username: username!, password: password!, code: nil)
        
        // Try to login with user provided data.
        self.login(credentials: authCredentials)
    }
    
    func login(code: String?) {
        
        guard credentialsValidator!.validate(otp: code) else {
            output?.invalidTwoFactorCode()
            return
        }
        
        if (authCredentials != nil) {
        
            // Seve received code.
            authCredentials.code = code
            
            // Login with updated credentials
            self.login(credentials: authCredentials)
        }
    }
    
    private func login(credentials: AuthCredentials) {
        
        authService?.login(withCredentials: credentials).then { token -> Void in
            
            self.tokenStorage?.saveTokenToSecureStorage(token)
            self.output?.authenticationSuccessfullyPassed()
            
        }.catch { error in
            // TODO: Should test this part.
            self.notifyWithAuthenticationError(error as! AuthenticationServiceError)
        }
    }
    
    private func notifyWithAuthenticationError(_ error: AuthenticationServiceError) {
        
        if error == .OTPRequired {
            output?.twoFactorAuthenticationRequired()
            return
        }
        
        output?.authenticationFailedWithBadCredentials()
    }
}

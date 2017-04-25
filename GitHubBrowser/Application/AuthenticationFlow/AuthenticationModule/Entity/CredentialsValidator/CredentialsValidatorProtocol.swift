//
//  CredentialsValidatorProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/25/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

/**
    Protocol defines specific methods that used by interactor to define 
    validation for specific credentials.
 */
protocol CredentialsValidatorProtocol: class {
    
    func validate(username: String?) -> Bool
    
    func validate(password: String?) -> Bool
    
    func validate(otp: String?) -> Bool
}

//
//  GitHubCredentialsValidator.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/25/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation

class GitHubCredentialsValidator: CredentialsValidatorProtocol {

    private struct RegEx {
        static let UserName = "^\\w+-?\\w+(?!-)$"
        static let Password = "(?=.*?[a-z])(?=.*?[0-9]).{8,}"
        static let OTP = "\\d+"
    }
    
    func validate(username: String?) -> Bool {
        return self.validate(string: username, expression: RegEx.UserName)
    }
    
    func validate(password: String?) -> Bool {
        return self.validate(string: password, expression: RegEx.Password)
    }
    
    func validate(otp: String?) -> Bool {
        return self.validate(string: otp, expression: RegEx.OTP)
    }
    
    private func validate(string: String?, expression: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", expression)
        return predicate.evaluate(with: string)
    }
}

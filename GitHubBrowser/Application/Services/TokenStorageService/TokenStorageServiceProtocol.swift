//
//  TokenStorageServiceProtocol.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Foundation
import PromiseKit

enum TokenStorageServiceError: Error {
    case NoTokenFound
}

protocol TokenStorageServiceProtocol: class {
    
    /**
        Offers method to save token securely.
        - parameter token: Auth2 token.
    */
    func saveTokenToSecureStorage(_ token: String)
    
    /**
        Offers ability to remove token from storage.
    */
    func removeTokenFromSecureStorage()
    
    /**
        Offers method that returns Token promise. Fetching can be async.
        - returns: A promise to get token.
    */
    func fetchTokenFromSecureStorage() -> Promise<String>
}

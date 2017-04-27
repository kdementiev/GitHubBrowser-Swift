//
//  SecureStorageService.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/24/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit
import PromiseKit
import KeychainSwift

class SecureStorageService: TokenStorageServiceProtocol {

    // Constants
    private struct Keychain {
        static let tokenAccessKey = "token_id"
    }
    
    private var keychain = KeychainSwift()
    static let sharedInstance = SecureStorageService()
    
    private init() {
        // Be in touch with iCloud.
        keychain.synchronizable = true
    }
    
    func saveTokenToSecureStorage(_ token: String!) {
        keychain.set(token, forKey: Keychain.tokenAccessKey, withAccess:.accessibleAlways)
    }
    
    func removeTokenFromSecureStorage() {
        keychain.delete(Keychain.tokenAccessKey)
    }
    
    func fetchTokenFromSecureStorage() -> Promise<String> {
        return Promise { fulfill, reject in
            
            guard let token = keychain.get(Keychain.tokenAccessKey) else {
                reject(TokenStorageServiceError.NoTokenFound)
                return
            }
            
            fulfill(token)
        }
    }
}

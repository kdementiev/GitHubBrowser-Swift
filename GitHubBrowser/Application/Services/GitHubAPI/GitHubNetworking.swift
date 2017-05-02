//
//  GitHubNetworking.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/29/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper


struct GitHubCredentials {
    
    var client: String
    var secret: String
}


class GitHubNetworking {
    
    static let defaultNetworking = GitHubNetworking()
    
    private struct InfoPlistKeys {
        
        static let Credentials = "GitHubCredentials"
        
        static let Client = "Client"
        static let Secret = "Secret"
    }
    
    private(set) var credentials: GitHubCredentials?
    

    private init() {
        
        guard let plistCredentials = Bundle.main.object(forInfoDictionaryKey: InfoPlistKeys.Credentials) else {
            assertionFailure("")
            return
        }
        
        
        
    }

    
}

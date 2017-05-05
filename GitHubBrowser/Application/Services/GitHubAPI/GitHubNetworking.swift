//
//  GitHubNetworking.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/29/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import PromiseKit

struct GitHubCredentials {
    
    var client: String!
    var secret: String!
    
    var baseURL: String!
}

protocol GitHubNetworkingRouter: URLRequestConvertible {
    
//    var 
}

class GitHubNetworking {
    
    static let defaultNetworking = GitHubNetworking()
    
    private struct InfoPlist {
        
        static let Credentials = "GitHubCredentials"
        
        static let Client = "Client"
        static let Secret = "Secret"
        static let Server = "Server"
    }
    
    private static let serverURL = "https://api.github.com"
    
    private(set) var credentials: GitHubCredentials!
    
    private init() {
        
        guard let plistCredentials = Bundle.main.object(forInfoDictionaryKey: InfoPlist.Credentials) as? [String : String] else {
            assertionFailure("You must provide GitHub credentials in your .plist file.")
            return
        }
        
        credentials = GitHubCredentials()
        
        credentials.client = plistCredentials[InfoPlist.Client]
        credentials.secret = plistCredentials[InfoPlist.Secret]
        credentials.baseURL = plistCredentials[InfoPlist.Server] ?? GitHubNetworking.serverURL
    }
    
    func request(forEndpoint endpoint: String) throws -> URLRequest {
        let url = try credentials.baseURL.asURL()
        return URLRequest(url: url.appendingPathComponent(endpoint))
    }
}

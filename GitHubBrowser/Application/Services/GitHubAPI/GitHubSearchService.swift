//
//  GitHubSearchService.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/27/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import PromiseKit
import CancellationToken

import Alamofire
import AlamofireObjectMapper


class GitHubSearchService {

    enum Router: URLRequestConvertible {
        case search(query: String)
        
        var endpoint: String {
            switch self {
            case .search(_):
                return "/search/repositories"
            }
        }
        
        var parameters: [String : String] {
            switch self {
            case .search(let query):
                return ["q": query]
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            let urlRequest = try GitHubNetworking.defaultNetworking.request(forEndpoint: endpoint)
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}

extension GitHubSearchService: SearchNetworkingServiceProtocol {
    
    func searchRepositories(withText text: String!, cancelltaionToken: CancellationToken?) -> Promise<[RepositoryRecord]> {
        
        return Promise { fulfill, reject in
            
            let task = Alamofire.request(Router.search(query: text)).responseObject { (response: DataResponse<GHPageEntity<GHRepositoryEntity>>) in

                switch response.result {
                case .success(let page):
                    fulfill(page.repositoryRecordsList())
                case .failure(let error):
                    reject(error)
                }
            }
            
            // Perform task cancelation.
            cancelltaionToken?.register {
                task.cancel()
            }
        }
    }
}

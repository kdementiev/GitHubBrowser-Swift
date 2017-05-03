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
        
        var path: String {
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
            let url = try GitHubNetworking.defaultNetworking.credentials.baseURL!.asURL()
            let urlRequest = URLRequest(url: url.appendingPathComponent(path))
            
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}

extension GitHubSearchService: SearchNetworkingServiceProtocol {
    
    func searchRepositories(withText text: String!, cancelltaionToken: CancellationToken?) -> Promise<[RepositoryRecord]> {
        
        return Promise { fulfill, reject in
            
            let task = Alamofire.request(Router.search(query: text)).responseObject { (response: DataResponse<GHPageEntity<GHRepositoryEntity>>) in
                
                // Validate response.
                guard let page = response.result.value else {
                    reject( NSError.cancelledError() )
                    return
                }
                
                // Try to map data.
                var repositories = [RepositoryRecord]()
                
                if let items = page.items {
                    for (_, repository) in items.enumerated() {
                        
                        let record = RepositoryRecord(ownerName: repository.owner?.login,
                                                      name: repository.name,
                                                      description: repository.description,
                                                      language: repository.language,
                                                      starsCount: repository.starsCount ?? 0)
                        
                        repositories.append(record)
                    }
                }
                
                fulfill(repositories)
            }
            
            // Perform task cancelation.
            cancelltaionToken?.register {
                task.cancel()
            }
        }
    }
}

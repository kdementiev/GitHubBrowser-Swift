//
//  MockSearchNetworkingService.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 5/4/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

import PromiseKit
import CancellationToken

@testable import GitHubBrowser


class MockSearchNetworkingService: SearchNetworkingServiceProtocol {

    var result: RepositoryRecord?
    var error: Error?
    
    func searchRepositories(withText text: String!, cancelltaionToken: CancellationToken?) -> Promise<[RepositoryRecord]> {
        
        return Promise { fulfill, reject in
            
            cancelltaionToken?.register {
                reject(NSError.cancelledError())
                return
            }
  
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1), execute: {
                if let result = self.result {
                    fulfill([result])
                    return
                }
                
                if let error = self.error {
                    reject(error)
                }
            })
        }
    }
}

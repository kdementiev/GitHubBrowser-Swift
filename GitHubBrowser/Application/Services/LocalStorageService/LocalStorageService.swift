//
//  LocalStorageService.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/26/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import PromiseKit
import CoreData

class LocalStorageService {
    
    private struct Storages {
        static let SearchHistory = "SearchHistoryStorage"
    }
    
    static let sharedInstance: LocalStorageService = LocalStorageService()
    
    fileprivate lazy var searchHistoryContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: Storages.SearchHistory)
        
        container.loadPersistentStores(completionHandler: { (desc: NSPersistentStoreDescription, error: Error?) in
            if let error = error as NSError? {
                NSLog("Error occured: %@", error)
            }
        })
        
        return container
    }()
}

extension LocalStorageService: LocalStorageServiceProtocol {
    
    func saveSearchQuery(_ query: String) {
        searchHistoryContainer.performBackgroundTask { (context: NSManagedObjectContext) in
            
            let fetchRequest = NSFetchRequest<SearchQueryEntity>(entityName: "SearchQueryEntity")
            
        }
    }
    
    func fetchSearchQueries() -> Promise<[SearchQueryRecord]> {
        return Promise { filfull, reject in
            searchHistoryContainer.performBackgroundTask({ (context: NSManagedObjectContext) in
                
            })
        }
    }
    
}

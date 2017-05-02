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
        
        container.loadPersistentStores { (desc: NSPersistentStoreDescription, error: Error?) in
            if let error = error as NSError? {
                NSLog("Error occured: %@", error)
            }
        }
        
        return container
    }()
}

extension LocalStorageService: LocalStorageServiceProtocol {
    
    func saveSearchQuery(_ query: String) {
        searchHistoryContainer.performBackgroundTask { (context: NSManagedObjectContext) in
            
            // Check for duplicated query.
            if self.fetchSearchQueryEntity(with: query, with: context) != nil {
                NSLog("Duplicated query. %@")
                return;
            }
            
            let searchQuery = SearchQueryEntity(context: context)
            searchQuery.query = query
            searchQuery.queryDate = Date()
            
            do {
                try context.save()
            }
            catch {
                NSLog("Failed to save context: %@", "\(error)")
            }
        }
    }
    
    func fetchSearchQueries() -> Promise<[SearchQueryRecord]> {
        return Promise { filfull, reject in
            searchHistoryContainer.performBackgroundTask { (context: NSManagedObjectContext) in
                
                let fetchRequest = SearchQueryEntity.fetchRequest() as! NSFetchRequest<SearchQueryEntity>
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "queryDate", ascending: false)]
            
                var mapperQueries = [SearchQueryRecord]()
                
                do {
                    // Try to fetch elements from storage.
                    let queries = try fetchRequest.execute()
                    
                    // Map fetched elements.
                    for (_, entity) in queries.enumerated() {
                        mapperQueries.append(SearchQueryRecord(query: entity.query, date: entity.queryDate))
                    }
                }
                catch {
                    NSLog("Failed to fetch enitites: %@", "\(error)")
                }
                
                filfull(mapperQueries)
            }
        }
    }
    
    private func fetchSearchQueryEntity(with query: String, with context: NSManagedObjectContext) -> SearchQueryEntity? {
        
        let fetchRequest = SearchQueryEntity.fetchRequest() as! NSFetchRequest<SearchQueryEntity>
        fetchRequest.predicate = NSPredicate(format: "query == %@", query)
        
        do {
            let result = try fetchRequest.execute()
            return result.first
        }
        catch {
            NSLog("Search query fetching failed.")
        }
        
        return nil
    }
    
}

//
//  SearchQueryEntity.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/26/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import CoreData

class SearchQueryEntity: NSManagedObject {
    
    @NSManaged var query: String?
    @NSManaged var queryDate: String?
    
}

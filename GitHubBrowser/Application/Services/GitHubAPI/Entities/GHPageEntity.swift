//
//  GHPageEntity.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/29/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import ObjectMapper

struct GHPageEntity<Element: Mappable>: Mappable {

    var count: Int?
    var incomplete: Bool?
    
    var items: [Element]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        count <- map["total_count"]
        incomplete <- map["incomplete_results"]
        
        items <- map["items"]
    }
}

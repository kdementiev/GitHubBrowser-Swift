//
//  GHUserEntity.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/29/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import ObjectMapper

struct GHUserEntity: Mappable {

    var id: Int?
    
    var login: String?
    var avatarUrl: String?
    
    var bio: String?
    
    var repositories: Int?
    var followers: Int?
    var following: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        
        login <- map["login"]
        avatarUrl <- map["avatar_url"]
        
        bio <- map["bio"]
        
        repositories <- map["public_repos"]
        followers <- map["followers"]
        following <- map["following"]
    }
}

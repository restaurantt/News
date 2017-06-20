//
//  SourceModel.swift
//  News
//
//  Created by Gu Jiajun on 2017/6/19.
//  Copyright © 2017年 gjj. All rights reserved.
//

import UIKit
import ObjectMapper

class SourceModel: Mappable {

    var id: String?
    var name: String?
    var detailDescription: String?
    var url: String?
    var category: String?
    var language: String?
    var country: String?
    var sortBysAvailable: [String?]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        detailDescription <- map["description"]
        url <- map["url"]
        category <- map["category"]
        language <- map["language"]
        country <- map["language"]
        sortBysAvailable <- map["sortBysAvailable"]
        
    }
}

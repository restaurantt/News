//
//  ArticleModel.swift
//  News
//
//  Created by Gu Jiajun on 2017/6/15.
//  Copyright © 2017年 gjj. All rights reserved.
//

import Foundation
import ObjectMapper

class ArticleModel: Mappable {

    var author: String?
    var title: String?
    var detailDescription: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    
    
    required init?(map: Map) {
//        super.init(map: map)
    }
    
    func mapping(map: Map) {
//        super.mapping(map: map)
        
        author <- map["author"]
        title <- map["title"]
        detailDescription <- map["description"]
        url <- map["url"]
        urlToImage <- map["urlToImage"]
        publishedAt <- map["publishedAt"]
    }
}

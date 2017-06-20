//
//  BaseArticleModel.swift
//  News
//
//  Created by Gu Jiajun on 2017/6/16.
//  Copyright © 2017年 gjj. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseArticleModel: Mappable {
    
    var status: String?
    var source: String?
    var sortBy: String?
    var articles: [ArticleModel]?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        source <- map["source"]
        sortBy <- map["sortBy"]
        articles <- map["articles"]
    }
}

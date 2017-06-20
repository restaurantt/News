//
//  BaseSourceModel.swift
//  News
//
//  Created by Gu Jiajun on 2017/6/19.
//  Copyright © 2017年 gjj. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseSourceModel: Mappable {

    var status: String?
    var sources: [SourceModel]?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        sources <- map["sources"]
    }
}

//
//  NewsAPI.swift
//  News
//
//  Created by Gu Jiajun on 2017/6/14.
//  Copyright © 2017年 gjj. All rights reserved.
//

import Foundation
import Moya
import Alamofire


enum NewsAPI {
    case Articles(source:String, apiKey:String,sortBy:String?)
    case Sources(category:String?,language:String?,country:String?)
}


extension NewsAPI: TargetType {

    var headers: [String : String]? {
        return nil
    }
    
    var baseURL: URL {
        return URL(string: "https://newsapi.org")!
    }
    
    var path: String {
        switch self {
        case .Articles(source: _, apiKey: _, sortBy: _):
            return "/v1/articles"
        case .Sources(_, _, _):
            return "/v1/sources"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .Articles(_, _, _):
            return .get
        case .Sources(_, _, _):
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .Articles(let source, let apiKey, let sortBy?):
            return ["source": source, "apiKey": apiKey, "sortBy": sortBy]
        case .Sources(let category?, let language?, let country?):
            return ["category": category, "language": language, "country": country]
        default:
            return nil
        }
    }

    
    var sampleData: Data {
        switch self {
        case .Articles:
            return "{\"status\": \"ok\",\"source\": \"the-next-web\",\"sortBy\": \"latest\",\"articles\": [{\"author\": \"Abhimanyu Ghoshal\",\"title\": \"Google\",\"description\": \"While \",\"url\": \"https://thenextweb.com/apps/2017/06/15/google-drive-will-automatically-back-up-your-hard-drive-later-this-month/\",\"urlToImage\": \"https://cdn0.tnwcdn.com/wp-content/blogs.dir/1/files/2017/06/Google-Drive-Backup-and-Sync.jpg\",\"publishedAt\": \"2017-06-15T06:01:25Z\"}]".data(using: String.Encoding.utf8)!
        case .Sources(_, _, _):
            return "Create post successfully".data(using: String.Encoding.utf8)!
        }
    }
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var validate: Bool {
        return false
    }
    
    var task: Task {
        return .request
    }
    
}


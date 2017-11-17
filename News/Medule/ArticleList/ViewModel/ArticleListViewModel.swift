//
//  ArticleListViewModel.swift
//  News
//
//  Created by Gu Jiajun on 2017/6/15.
//  Copyright © 2017年 gjj. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class ArticleListViewModel: BaseViewModel {
//    var articleArray = [ArticleModel]()
    var articleArray = NSMutableArray()
    
    private let provider = RxMoyaProvider<NewsAPI>()
    
    func getArticles(page:Int, source:String) -> Observable<BaseArticleModel> {
        return provider.request(.Articles(source: source, apiKey: NewsAPIKey, sortBy: "top"))
        .filterSuccessfulStatusCodes()
        .mapJSON()
        .mapObject(type: BaseArticleModel.self)
//        .mapArray(type: ArticleModel.self)
        
    }
}

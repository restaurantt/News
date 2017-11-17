//
//  SourceViewModel.swift
//  News
//
//  Created by Gu Jiajun on 2017/6/19.
//  Copyright © 2017年 gjj. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class SourceViewModel: BaseViewModel {
    var sourceArray = NSMutableArray()
    
    
    private let provider = RxMoyaProvider<NewsAPI>()
    
    func getSources() -> Observable<BaseSourceModel> {

        return provider.request(.Sources(category: "", language: "", country: ""))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .mapObject(type: BaseSourceModel.self)
        //        .mapArray(type: ArticleModel.self)
        
    }
}

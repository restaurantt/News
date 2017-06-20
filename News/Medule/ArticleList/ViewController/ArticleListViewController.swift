//
//  ArticleListViewController.swift
//  News
//
//  Created by Gu Jiajun on 2017/6/15.
//  Copyright © 2017年 gjj. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import RxCocoa
import RxDataSources
import SnapKit
import ESPullToRefresh
import PKHUD

class ArticleListViewController: BaseViewController, UITableViewDelegate,UITableViewDataSource {
    var page = 0
    
    let disposeBag = DisposeBag()
    let viewModel = ArticleListViewModel()
    var currentSource = defaultSource
    
    let tableView: UITableView = UITableView(frame: UIScreen.main.bounds,style:.plain)
    let reuseIdentifier = "(ArticleCell.self)"
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, ArticleModel>>()

    var sourceBtn = UIButton()
    var sourceItem: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.title = "News"
        
        let leftItem = UIBarButtonItem(image: UIImage(named: "setIcon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.setAction))
        self.navigationItem.leftBarButtonItem = leftItem;
        
        sourceBtn.kf.setImage(with: URL(string: defaultSourceUrl), for: .normal)
//        sourceBtn.setImage(UIImage(named: "setIcon"), for: .normal)
        sourceBtn.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        sourceBtn.addTarget(self, action: #selector(self.sourceBtnAction), for: .touchUpInside)
        sourceItem = UIBarButtonItem(customView: sourceBtn)
        self.navigationItem.rightBarButtonItem = sourceItem
        
        setupView()
        setRefreshView()
        //setLoadMoreView()
        
        bindData()
        requestData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleCell.self, forCellReuseIdentifier: reuseIdentifier)

        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.left.right.bottom.equalTo(self.view);
        }
        
    }
    
    func setRefreshView() {
        self.tableView.es_addPullToRefresh {
            [weak self] in
            /// 在这里做刷新相关事件
            self?.refreshData()
            
            /// 如果你的刷新事件成功，设置completion自动重置footer的状态
            //self?.tableView.es_stopPullToRefresh()
            /// 设置ignoreFooter来处理不需要显示footer的情况
            //self?.tableView.es_stopPullToRefresh(completion: true, ignoreFooter: false)
        }
    }
    
    func refreshData() {
        self.page = 0
        self.viewModel.articleArray.removeAllObjects()
        self.requestData()
    }
    
//    func setLoadMoreView() {
//        self.tableView.es_addInfiniteScrolling {
//            [weak self] in
//            /// 在这里做加载更多相关事件
//            self?.requestData()
//            /// 如果你的加载更多事件成功，调用es_stopLoadingMore()重置footer状态
//            self?.tableView.es_stopLoadingMore()
//            /// 通过es_noticeNoMoreData()设置footer暂无数据状态
//            //self?.tableView.es_noticeNoMoreData()
//        }
//    }
    
    func bindData() {
        
        
        
//        dataSource.configureCell = { (_, tableView, indexPath, model) in
//            let cell: ArticleCell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier) as! ArticleCell
//            
//            cell.model = model
//        
//            return cell
//        }

    }
    
    func requestData() {
        HUD.show(.systemActivity)
        viewModel.getArticles(page: page, source: currentSource)
            .subscribe(onNext: { (model: BaseArticleModel) in
                if (model.articles?.count)! > 0 {
                    self.viewModel.articleArray.addObjects(from: model.articles!)
                    self.tableView.reloadData()
                    //self.page = self.page + 1;
                }
                HUD.hide()
            }, onError: { (error) in
                print(error)
                HUD.show(.label("error"))
            }, onCompleted: {
                print("complete")
                self.tableView.es_stopPullToRefresh()
            }) {
                
            }.addDisposableTo(disposeBag)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.articleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ArticleCell(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        
        cell.model = self.viewModel.articleArray[indexPath.row] as? ArticleModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    
    func setAction() {
        
    }
    
    func sourceBtnAction() {
        let vc = SourceViewController()
        weak var WeakSelf = self
        // 第一用方法
        vc.didSelectSource = { (model) -> () in

            let urlStr = "https://icons.better-idea.org/icon?url="+(model.url)!+"&amp;size=70..120..200"
            WeakSelf!.sourceBtn.kf.setImage(with: URL(string: urlStr), for: .normal)
            WeakSelf!.currentSource = model.id!
            WeakSelf!.refreshData()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

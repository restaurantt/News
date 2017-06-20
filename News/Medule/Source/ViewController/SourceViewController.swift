//
//  SourceViewController.swift
//  News
//
//  Created by Gu Jiajun on 2017/6/19.
//  Copyright © 2017年 gjj. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import RxCocoa
import RxDataSources
import SnapKit
import PKHUD

class SourceViewController: BaseViewController, UICollectionViewDelegate,UICollectionViewDataSource {

    typealias selectSource = (SourceModel) -> ()
    var didSelectSource :selectSource?
    
    let disposeBag = DisposeBag()
    let viewModel = SourceViewModel()
    
    var colltionView : UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.title = "News"
        
        setupView()
        
        bindData()
        requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        colltionView = UICollectionView(frame:CGRect.init(x: 0, y: 0, width: 0, height: 0) , collectionViewLayout: layout)
        //注册一个cell
        colltionView! .register(SourceCell.self, forCellWithReuseIdentifier:"SourceCell")
        //注册一个headView
        colltionView! .register(SourceHeaderView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "SourceHeaderView")
        colltionView?.delegate = self;
        colltionView?.dataSource = self;
        
        colltionView?.backgroundColor = UIColor.white
        //设置每一个cell的宽高
        layout.itemSize = CGSize.init(width: (ScreenWidth-50)/4, height: (ScreenWidth-50)/4+45)
        self.view.addSubview(colltionView!)
        colltionView!.snp.makeConstraints { (make) -> Void in
            make.top.left.right.bottom.equalTo(self.view);
        }
    }
    
    func bindData() {
        
    }
    
    func requestData() {
        HUD.show(.systemActivity)
        viewModel.getSources()
            .subscribe(onNext: { (model: BaseSourceModel) in
                if (model.sources?.count)! > 0 {
                    self.viewModel.sourceArray.addObjects(from: model.sources!)
                    
                    self.colltionView?.reloadData()
                }
                HUD.hide()
            }, onError: { (error) in
                print(error)
                HUD.show(.label("error"))
            }, onCompleted: {
                print("complete")
                
            }) {
                
            }.addDisposableTo(disposeBag)
    }
    
    //返回多少个组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.sourceArray.count
    }
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SourceCell", for: indexPath) as! SourceCell
        
        cell.model = self.viewModel.sourceArray[indexPath.item] as? SourceModel
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectSource!(self.viewModel.sourceArray[indexPath.item] as! SourceModel)
        self.navigationController?.popViewController(animated: true)
    }
    
    //返回HeadView的宽高
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHe
//        aderInSection section: Int) -> CGSize{
//        
//        return CGSize(width: width, height: height/1.6)
//    }
    
    
    //返回自定义HeadView或者FootView，我这里以headview为例
//    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView{
//        var v = Home_HeadView()
//        if kind == UICollectionElementKindSectionHeader{
//            
//            v = colltionView!.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "headView", forIndexPath: indexPath) as! Home_HeadView
//        }
//        return v
//    }
    //返回cell 上下左右的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(10, 0, 10, 0)

//        return UIEdgeInsetsMake(10, 10, 10, 10)
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

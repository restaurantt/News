//
//  SourceCell.swift
//  News
//
//  Created by Gu Jiajun on 2017/6/20.
//  Copyright © 2017年 gjj. All rights reserved.
//

import UIKit

class SourceCell: UICollectionViewCell {
    
    var logoView:      UIImageView = UIImageView(image: UIImage(named: "setIcon"))
    var titleLbl:       UILabel = UILabel()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        logoView.contentMode = UIViewContentMode.scaleAspectFit
        self.contentView.addSubview(logoView)
        logoView.snp.makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self.contentView).offset(0)
            make.height.equalTo(self.contentView.snp.width)
        }
        
        titleLbl.font = UIFont.boldSystemFont(ofSize: 13)
        titleLbl.textAlignment = .center
        titleLbl.numberOfLines = 2
        self.contentView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.logoView.snp.bottom).offset(5)
            make.left.equalTo(self.logoView.snp.left).offset(3)
            make.right.equalTo(self.logoView.snp.right).offset(-3)
            make.height.equalTo(40)
        }
    }
    
    var model: SourceModel? {
        willSet {
            let urlStr = "https://icons.better-idea.org/icon?url="+(newValue?.url)!+"&amp;size=70..120..200"
            let url = URL(string: urlStr)
            logoView.kf.setImage(with: url)
            titleLbl.text = newValue?.name
            
        }
    }
}

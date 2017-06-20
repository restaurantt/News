//
//  ArticleCell.swift
//  News
//
//  Created by Gu Jiajun on 2017/6/19.
//  Copyright © 2017年 gjj. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleCell: UITableViewCell {

    var thumbView:      UIImageView = UIImageView(image: UIImage(named: "setIcon"))
    var titleLbl:       UILabel = UILabel()
    var detailLbl:      UILabel = UILabel()
    var publishDateLbl: UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        thumbView.contentMode = UIViewContentMode.scaleAspectFit
        self.contentView.addSubview(thumbView)
        thumbView.snp.makeConstraints { (make) -> Void in
            make.top.left.equalTo(self.contentView).offset(15)
            make.size.equalTo(CGSize(width: 90, height: 70))
        }
        
        titleLbl.font = UIFont.boldSystemFont(ofSize: 15)
        titleLbl.numberOfLines = 2
        self.contentView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.thumbView)
            make.left.equalTo(self.thumbView.snp.right).offset(10)
            make.height.equalTo(40)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
        }
        
        detailLbl.numberOfLines = 2
        detailLbl.font = UIFont.systemFont(ofSize: 13);
        self.contentView.addSubview(detailLbl)
        detailLbl.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.titleLbl.snp.bottom).offset(3)
            make.left.equalTo(self.titleLbl.snp.left)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.height.equalTo(40)
        }
        
        self.contentView.addSubview(publishDateLbl)


    }
    
    
    var model: ArticleModel? {
        willSet {
            let url = URL(string: (newValue?.urlToImage)!)
            thumbView.kf.setImage(with: url)
            titleLbl.text = newValue?.title
            detailLbl.text = newValue?.detailDescription
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

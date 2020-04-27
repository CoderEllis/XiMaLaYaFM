//
//  LBRecommendForYouCell.swift
//  xmlyFM
//
//  Created by Soul on 22/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBRecommendForYouCell: UICollectionViewCell {
    // 图片
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    // 标题
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    // 子标题
    private var subLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    // 子标题
    private var numLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI(){
        addSubview(imageView)
        imageView.image = UIImage(named: "pic1.jpeg")
        imageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(80)
        }
        addSubview(titleLabel)
        titleLabel.text = "房价那些事"
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(10)
            make.right.equalToSuperview()
            make.top.equalTo(imageView)
            make.height.equalTo(20)
        }
        
        addSubview(subLabel)
        subLabel.text = "卖房子卖房子"
        subLabel.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        addSubview(numLabel)
        numLabel.text = "> 2.5亿 1284集"
        numLabel.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(subLabel)
            make.bottom.equalToSuperview().offset(-15)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

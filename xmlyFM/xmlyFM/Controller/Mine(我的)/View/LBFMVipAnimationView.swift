//
//  LBFMVipAnimationView.swift
//  xmlyFM
//
//  Created by Soul on 19/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
/// 上下浮动vip领取view
class LBFMVipAnimationView: UIView {

    // 图片
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vip")
        return imageView
    }()

    // 标题
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "VIP会员"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    // 介绍
    private lazy var desLabel: UILabel = {
        let label = UILabel()
        label.text = "免费领取7天会员"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    // 箭头
    private lazy var arrowsLabel: UILabel = {
        let label = UILabel()
        label.text = ">"
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(red: 212.0 / 255.0, green: 212.0 / 255.0, blue: 212.0 / 255.0, alpha: 212.0 / 255.0)
        setUpLayout()
    }
    
    func setUpLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(5)
            make.width.height.equalTo(30)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(5)
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.centerY.equalTo(imageView)
        }
        
        addSubview(desLabel)
        desLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.width.equalTo(180)
            make.height.equalTo(20)
        }
        
        addSubview(arrowsLabel)
        arrowsLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.width.height.equalTo(20)
            make.top.equalTo(20)
        }
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

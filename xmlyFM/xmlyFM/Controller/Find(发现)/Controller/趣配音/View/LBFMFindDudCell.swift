
//
//  LBFMFindDudCell.swift
//  xmlyFM
//
//  Created by Soul on 21/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMFindDudCell: UITableViewCell {
    ///图片
    lazy var picView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    ///标题
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.white
        return label
    }()
    ///头像
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    ///昵称
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        return label
    }()
    
    ///赞
    private lazy var zanLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        return label
    }()
    private lazy var zanImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    ///评论
    private lazy var commnetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        return label
    }()
    private lazy var commnetView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    func setUpLayout() {
        addSubview(picView)
        picView.layer.masksToBounds = true
        picView.layer.cornerRadius = 5
        picView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-60)
        }
        
        picView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
        
        addSubview(iconView)
        iconView.image = UIImage(named: "news.png")
        iconView.layer.masksToBounds = true
        iconView.layer.cornerRadius = 15
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(picView)
            make.bottom.equalToSuperview().offset(-15)
            make.width.height.equalTo(30)
        }
        
        addSubview(nameLabel)
        nameLabel.text = "喜马拉雅好声音"
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView).offset(10)
            make.centerY.equalTo(iconView)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
        addSubview(commnetLabel)
        commnetLabel.text = "8494"
        commnetLabel.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(30)
            make.height.equalTo(20)
        }
        
        addSubview(commnetView)
        commnetView.image = UIImage(named: "评论")
        commnetView.snp.makeConstraints { (make) in
            make.right.equalTo(commnetLabel.snp.left).offset(-5)
            make.width.height.equalTo(25)
            make.centerY.equalTo(commnetLabel)
        }
        
        addSubview(zanLabel)
        zanLabel.text = "20.4万"
        zanLabel.snp.makeConstraints { (make) in
            make.right.equalTo(commnetView.snp.left).offset(-10)
            make.width.equalTo(30)
            make.height.equalTo(20)
            make.centerY.equalTo(commnetView)
        }
        
        addSubview(zanImageView)
        zanImageView.image = UIImage(named: "点赞")
        zanImageView.snp.makeConstraints { (make) in
            make.right.equalTo(zanLabel.snp.left).offset(-5)
            make.width.height.equalTo(20)
            make.centerY.equalTo(zanLabel)
        }
        
    }
    
    var findDudModel :LBFMFindDudModel? {
        didSet {
            guard let model = findDudModel else {
                return
            }
            picView.kf.setImage(with: URL(string: (model.dubbingItem?.coverPath)!))
            titleLabel.text = model.dubbingItem?.intro
            iconView.kf.setImage(with: URL(string: (model.dubbingItem?.logoPic)!))
            nameLabel.text = model.dubbingItem?.nickname
            let zanNum:Int = (model.dubbingItem?.favorites)!
            zanLabel.text = "\(zanNum)"
            let commentNum:Int = (model.dubbingItem?.commentCount)!
            commnetLabel.text = "\(commentNum)"
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

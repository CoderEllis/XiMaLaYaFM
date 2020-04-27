//
//  LBFMPlayAnchorCell.swift
//  xmlyFM
//
//  Created by Soul on 25/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMPlayAnchorCell: UICollectionViewCell {
    // 头像
    lazy var picView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    //昵称
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    //关注
    lazy var attentionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.gray
        return label
    }()
    // 言论
    lazy var desLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    // bgimageView
    lazy var bgImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search_hint_histrack_bg_297x33_")
        return imageView
    }()
    
    // 赞助按钮
    private lazy var sponsorBtn:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "sponsorBtn_41x30_"), for: .normal)
        //        button.addTarget(self, action: #selector(playBtn(button:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpUI() {
        addSubview(picView)
        picView.image = UIImage(named: "news.png")
        picView.layer.masksToBounds = true
        picView.layer.cornerRadius = 20
        picView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(40)
        }
        
        addSubview(nameLabel)
        nameLabel.text = "喜马拉雅"
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(picView.snp.right).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(20)
            make.top.equalTo(picView)
        }
        addSubview(attentionLabel)
        attentionLabel.text = "已被5.5万人关注"
        attentionLabel.snp.makeConstraints { (make) in
            make.left.width.height.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.top.equalTo(picView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        bgImageView.addSubview(desLabel)
        desLabel.text = "四六级发送到"
        desLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.right.bottom.equalToSuperview().offset(-10)
        }
        
        addSubview(sponsorBtn)
        sponsorBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(41)
            make.height.equalTo(30)
            make.centerY.equalTo(picView)
        }
    }
    
    var userInfo : LBFMPlayUserInfo? {
        didSet {
            guard let model = userInfo else {
                return
            }
            picView.kf.setImage(with: URL(string: model.smallLogo!))
            nameLabel.text = model.nickname
            desLabel.text = model.skilledTopic
            
            var tagString: String = ""
            if model.followers > 100000000 {
                tagString = String(format: "%.1f亿", Double(model.followers) / 100000000)
            } else if model.followers > 10000{
                tagString = String(format: "%.1f 万", Double(model.followers) / 10000)
            } else {
                tagString = "\(model.followers)"
            }
            attentionLabel.text = "已被\(tagString)关注"
        }
    }
    
}

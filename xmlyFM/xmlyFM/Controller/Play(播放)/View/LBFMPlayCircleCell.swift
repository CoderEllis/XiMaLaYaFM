//
//  LBFMPlayCircleCell.swift
//  xmlyFM
//
//  Created by Soul on 25/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMPlayCircleCell: UICollectionViewCell {
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
    //    // 言论
    lazy var desLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    // bgimageView
    lazy var bgImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cell_bg_commentline_355x86_")
        return imageView
    }()
    
    //加入按钮
    private lazy var joinBtn:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("加入", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = LBFMButtonColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    func setUpUI(){
        addSubview(picView)
        picView.image = UIImage(named: "news.png")
        picView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(40)
        }
        
        addSubview(nameLabel)
        nameLabel.text = "喜马拉雅好"
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(picView.snp.right).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(20)
            make.top.equalTo(picView)
        }
        addSubview(attentionLabel)
        attentionLabel.text = "成员 793   帖子 46"
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
            make.right.bottom.equalToSuperview().offset(-15)
        }
        
        addSubview(joinBtn)
        joinBtn.layer.masksToBounds = true
        joinBtn.layer.cornerRadius = 15
        joinBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(50)
            make.height.equalTo(30)
            make.centerY.equalTo(picView)
        }
    }
    
    var communityInfo: LBFMPlayCommunityInfo? {
        didSet{
            guard let model = communityInfo else {return}
            picView.kf.setImage(with: URL(string: model.logoSmall!))
            nameLabel.text = model.name
            desLabel.text = model.introduce
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

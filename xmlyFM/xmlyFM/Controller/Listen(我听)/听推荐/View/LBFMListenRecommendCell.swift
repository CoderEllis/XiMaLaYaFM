//
//  LBFMListenRecommendCell.swift
//  xmlyFM
//
//  Created by Soul on 19/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMListenRecommendCell: UITableViewCell {
    // 背景大图
    private var picView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 3
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // 标题
    private var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    // 副标题
    private var subLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    // 播放数量
    private var numLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    // 集数
    private var tracksLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    // 播放数量图片
    private var numView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "playcount.png")
        return imageView
    }()
    
    // 集数图片
    private var tracksView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "track.png")
        return imageView
    }()
    
    // 订阅按钮
    private var subscibeBtn : UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("+订阅", for: .normal)
        btn.setTitleColor(LBFMButtonColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.backgroundColor = UIColor(r: 254.0, g: 232.0, b: 227.0)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    
    
    func setUpLayout() {
        addSubview(picView)
        picView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(70)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(picView.snp.right).offset(10)
            make.top.equalTo(picView)
            make.height.equalTo(20)
            make.right.equalToSuperview()
        }
        
        addSubview(subLabel)
        subLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.height.right.equalTo(titleLabel)        }
        
        addSubview(numView)
        numView.snp.makeConstraints { (make) in
            make.left.equalTo(subLabel)
            make.bottom.equalTo(picView)
            make.width.equalTo(17)
        }
        
        addSubview(numLabel)
        numLabel.snp.makeConstraints { (make) in
            make.left.equalTo(numView.snp.right).offset(5)
            make.width.equalTo(60)
            make.bottom.equalTo(numView)
        }
        
        addSubview(tracksView)
        tracksView.snp.makeConstraints { (make) in
            make.left.equalTo(numLabel.snp.right).offset(5)
            make.width.equalTo(20)
            make.bottom.equalTo(numLabel)
        }
        
        addSubview(tracksLabel)
        tracksLabel.snp.makeConstraints { (make) in
            make.left.equalTo(tracksView.snp.right).offset(5)
            make.width.equalTo(80)
            make.bottom.equalTo(tracksView)
        }
        
        addSubview(subscibeBtn)
        subscibeBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(60)
            make.height.equalTo(24)
            make.centerY.equalTo(tracksLabel)
        }
    }
    
    ///模型属性赋值
    var albums : albumsModel? {
        didSet {
            guard let model = albums else {
                return
            }
            picView.kf.setImage(with: URL(string: model.coverMiddle!))
            titleLabel.text = model.title
            subLabel.text = model.recReason
            tracksLabel.text = "\(model.tracks)集"
            
            var tagString : String?
            if model.playsCounts > 100000000 {
                tagString = String(format: "%.1f亿", Double(model.playsCounts) / 100000000)
            } else if model.playsCounts > 10000 {
                tagString = String(format: ".1f万", Double(model.playsCounts / 10000))
            } else {
                tagString = "\(model.playsCounts)"
            }
            
            numLabel.text = tagString
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

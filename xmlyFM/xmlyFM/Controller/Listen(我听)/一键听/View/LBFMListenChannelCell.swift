

//
//  LBFMListenChannelCell.swift
//  xmlyFM
//
//  Created by Soul on 20/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import JXMarqueeView

class LBFMListenChannelCell: UITableViewCell {
    private let marqueeView = JXMarqueeView()
    
    // 背景大图
    private lazy var picView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    // 标题
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    // 滚动文字
    private lazy var scrollLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    // 播放按钮
    private lazy var playBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "whitePlay"), for: .normal)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    func setUpLayout() {
        addSubview(picView)
        picView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        picView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(20)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        // 文字跑马灯效果
        marqueeView.contentView = scrollLabel
        marqueeView.contentMargin = 10
        marqueeView.marqueeType = .reverse
        picView.addSubview(marqueeView)
        marqueeView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.height.equalTo(25)
            make.right.equalToSuperview().offset(-70)
        }
        
        picView.addSubview(playBtn)
        playBtn.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview().offset(-15)
            make.width.height.equalTo(45)
        }
    }
    
    
    
    /// 一键听主页数据模型
    var channelClassInfo : ChannelResultsModel? {
        didSet {
            guard let model = channelClassInfo else {
                return
            }
            picView.kf.setImage(with: URL(string: model.bigCover!))
            titleLabel.text = model.channelName
            scrollLabel.text = model.slogan
        }
    }
    
    /// 更多频道数据模型
    var channelInfoModel : ChannelInfosModel? {
        didSet {
            guard let model = channelInfoModel else {
                return
            }
            picView.kf.setImage(with: URL(string: model.bigCover!))
            titleLabel.text = model.channelName
            scrollLabel.text = model.slogan
            titleLabel.font = UIFont.systemFont(ofSize: 22)
            scrollLabel.font = UIFont.systemFont(ofSize: 16)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

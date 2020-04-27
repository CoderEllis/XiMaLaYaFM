//
//  LBFMPlayCommentCell.swift
//  xmlyFM
//
//  Created by Soul on 25/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMPlayCommentCell: UICollectionViewCell {
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
    // 言论
    lazy var desLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    // 日期
    lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        return label
    }()
    // 赞
    lazy var zanLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        return label
    }()
    lazy var zanImageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    func setUpUI(){
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
            make.height.equalTo(30)
            make.centerY.equalTo(picView)
        }
        
        addSubview(desLabel)
        desLabel.text = "四六级发送到了解放塑料袋就分手发熟练度家纺"
        desLabel.snp.makeConstraints { (make) in
            make.left.equalTo(picView.snp.right).offset(10)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(50)
        }
        
        addSubview(dateLabel)
        dateLabel.text = "一天前"
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(picView)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        addSubview(zanLabel)
        zanLabel.text = "20.4万"
        zanLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        addSubview(zanImageView)
        zanImageView.image = UIImage(named: "点赞")
        zanImageView.snp.makeConstraints { (make) in
            make.right.equalTo(zanLabel.snp.left).offset(-5)
            make.width.height.equalTo(20)
            make.centerY.equalTo(zanLabel)
        }
    }
    
    var playCommentInfo:LBFMPlayCommentInfo?{
        didSet{
            guard let model = playCommentInfo else {return}
            picView.kf.setImage(with: URL(string: model.smallHeader!))
            nameLabel.text = model.nickname
            desLabel.text = model.content
            dateLabel.text = updateTimeToCurrennTime(timeStamp: Double(model.createdAt))
            zanLabel.text = "\(model.likes)"
            let textHeight:CGFloat = height(for: model)
            desLabel.snp.updateConstraints { (make) in
                make.height.equalTo(textHeight)
            }
            
        }
    }
    // 计算文本高度
    func height(for commentModel: LBFMPlayCommentInfo?) -> CGFloat {
        var height: CGFloat = 10
        guard let model = commentModel else { return height }
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = model.content
        height += label.sizeThatFits(CGSize(width: ScreenWidth - 80, height: CGFloat.infinity)).height
        return height
    }
    
    // - 根据后台时间戳返回几分钟前，几小时前，几天前
    func updateTimeToCurrennTime(timeStamp: Double) -> String {
        //获取当前的时间戳
        let currentTime = Date().timeIntervalSince1970
        //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let timeSta:TimeInterval = TimeInterval(timeStamp / 1000)
        //时间差
        let reduceTime : TimeInterval = currentTime - timeSta
        //时间差小于60秒
        if reduceTime < 60 {
            return "刚刚"
        }
        //时间差大于一分钟小于60分钟内
        let mins = Int(reduceTime / 60)
        if mins < 60 {
            return "\(mins)分钟前"
        }
        let hours = Int(reduceTime / 3600)
        if hours < 24 {
            return "\(hours)小时前"
        }
        let days = Int(reduceTime / 3600 / 24)
        if days < 30 {
            return "\(days)天前"
        }
        //不满足上述条件---或者是未来日期-----直接返回日期
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="yyyy年MM月"
        return dfmatter.string(from: date as Date)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

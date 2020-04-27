
//
//  LBFMFindAttentionCell.swift
//  xmlyFM
//
//  Created by Soul on 21/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMFindAttentionCell: UITableViewCell {
    private let LBFMFindAttentionPicCellID = "LBFMFindAttentionPicCell"
    //头像
    private lazy var picView : UIImageView = {
        let imageVC = UIImageView()
        return imageVC
    }()
    
    // 昵称
    private lazy var nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        return nameLabel
    }()
    
    //言论
    private lazy var desLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    //日期
    private lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    // 赞
    private lazy var zanLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private lazy var zanImageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // 评论数量
    private lazy var commnetLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .right
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private lazy var commnetImageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(LBFMFindAttentionPicCell.self, forCellWithReuseIdentifier: LBFMFindAttentionPicCellID)
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpLayout() {
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
            make.left.equalTo(picView.snp.right).offset(8)
            make.width.equalTo(200)
            make.height.equalTo(30)
            make.centerY.equalTo(picView)
        }
        
        addSubview(desLabel)
        desLabel.text = "四六级发送到了"
        desLabel.backgroundColor = UIColor.lightGray
        desLabel.snp.makeConstraints { (make) in
            make.left.equalTo(picView)
            make.top.equalTo(picView.snp.bottom).offset(8)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(20)
        }
        
        addSubview(dateLabel)
        dateLabel.text = "一天前"
        dateLabel.backgroundColor = UIColor.yellow
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(picView)
            make.bottom.equalToSuperview().offset(-15)
            make.height.equalTo(20)
            make.width.equalTo(160)
        }
        
        addSubview(commnetLabel)
        commnetLabel.text = "8494"
        commnetLabel.backgroundColor = UIColor.yellow
        commnetLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(20)
            make.width.equalTo(40)
        }
        
        addSubview(commnetImageView)
        commnetImageView.backgroundColor = UIColor.blue
        commnetImageView.image = UIImage(named: "评论")
        commnetImageView.snp.makeConstraints { (make) in
            make.right.equalTo(commnetLabel.snp.left).offset(-5)
            make.centerY.equalTo(commnetLabel)
            make.width.height.equalTo(25)
        }
        
        addSubview(zanLabel)
        zanLabel.text = "20.4万"
        zanLabel.snp.makeConstraints { (make) in
            make.right.equalTo(commnetImageView.snp.left).offset(-10)
            make.height.equalTo(20)
            make.width.equalTo(40)
            make.centerY.equalTo(commnetImageView)
        }
        
        addSubview(zanImageView)
        zanImageView.image = UIImage(named: "点赞")
        zanImageView.snp.makeConstraints { (make) in
            make.right.equalTo(zanLabel.snp.left).offset(-5)
            make.centerY.equalTo(zanLabel)
            make.width.height.equalTo(20)
        }
        
        addSubview(collectionView)
        collectionView.backgroundColor = UIColor.red
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(desLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(ScreenWidth - 30)
        }
    }
    private var eventInfos : LBFMEventInfosModel?
    var eventInfosModel : LBFMEventInfosModel? {
        didSet {
            guard let model = eventInfosModel else {
                return
            }
            picView.kf.setImage(with: URL(string: (model.authorInfo?.avatarUrl)!))
            nameLabel.text = model.authorInfo?.nickname
            let zanNum: Int = (model.statInfo?.praiseCount)!
            zanLabel.text = "\(zanNum)"
            let commentNum: Int = (model.statInfo?.commentCount)!
            commnetLabel.text = "\(commentNum)"
            desLabel.text = model.contentInfo?.text
            let textHeight:CGFloat = height(for: model.contentInfo)
            desLabel.snp.updateConstraints { (make) in
                make.height.equalTo(textHeight)
            }
            
            dateLabel.text = updateTimeToCurrennTime(timeStamp: Double(CGFloat(model.timeline)))
            eventInfos = model
            
            let picNum = eventInfos?.contentInfo?.picInfos?.count ?? 0
            var num:CGFloat = 0
            if picNum > 0 && picNum <= 3 {
                num = 1
            } else if picNum > 3 && picNum <= 6{
                num = 2
            } else if picNum > 6{
                num = 3
            }
            
            let OnePicHeight = CGFloat((ScreenWidth - 30) / 3)
            let picHeight = num * OnePicHeight
            collectionView.snp.updateConstraints { (make) in
                make.height.equalTo(picHeight)
            }
            collectionView.reloadData()
            
        }
    }
    
    func height(for commentModel:LBFMFindAContentInfo?) -> CGFloat {
        var height: CGFloat = 30
        guard let model =  commentModel else {
            return height
        }
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.text = model.text
        height += label.sizeThatFits(CGSize(width: ScreenWidth - 30, height: CGFloat.infinity)).height
        return height
    }
    
    // - 根据后台时间戳返回几分钟前，几小时前，几天前
    func updateTimeToCurrennTime(timeStamp: Double) -> String {
        // 获取当前的时间戳
        let currentTime = Date().timeIntervalSince1970
        // 时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let timeSta: TimeInterval = TimeInterval(timeStamp / 1000)
        // 时间差
        let reduceTime: TimeInterval = currentTime - timeSta
        // 时间差小于60秒
        if reduceTime < 60 {
            return "刚刚"
        }
        // 时间差大于一分钟小于60分钟内
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
        
        // 不满足上述条件---或者是未来日期-----直接返回日期
        let date = Date(timeIntervalSince1970: timeSta)
        
        let dfmatter = DateFormatter()
        // yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        return dfmatter.string(from: date)
        
    }
    
}

extension LBFMFindAttentionCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventInfos?.contentInfo?.picInfos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LBFMFindAttentionPicCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMFindAttentionPicCellID, for: indexPath) as! LBFMFindAttentionPicCell
        cell.picModel = eventInfos?.contentInfo?.picInfos?[indexPath.row]
        return cell
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: ((ScreenWidth - 30) / 3), height: (ScreenWidth - 30) / 3)
    }
}

//
//  LBFMRecommendLiveCell.swift
//  xmlyFM
//
//  Created by Soul on 24/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMRecommendLiveCell: UICollectionViewCell {
    // 图片
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    // 标题
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    // 子标题
    private var subLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()
    
    // categoryName
    private var categoryL : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.orange
        return label
    }()
    
    /// 播放器动画效果
    private var replicatorLayer:ReplicatorLayer = {
        let layer = ReplicatorLayer.init(frame: CGRect(x: 0, y: 0, width: 2, height: 15))
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpLayout(){
        addSubview(imageView)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        imageView.addSubview(categoryL)
        categoryL.layer.masksToBounds = true
        categoryL.layer.cornerRadius = 4
        categoryL.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(30)
            make.height.equalTo(20)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom)
            make.height.equalTo(20)
        }
        
        addSubview(subLabel)
        subLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
        
        imageView.addSubview(replicatorLayer)
        replicatorLayer.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(20)
            make.height.equalTo(10)
        }
    }
    
    var recommendliveData:LBFMLiveModel? {
        didSet{
            guard let model = recommendliveData else { return }
            if (model.coverMiddle != nil) {
                imageView.kf.setImage(with: URL(string: model.coverMiddle!))
            }
            titleLabel.text = model.nickname
            subLabel.text = model.name
            categoryL.text = model.categoryName
        }
    }
    
    var liveData:LBFMLivesModel? {
        didSet{
            guard let model = liveData else { return }
            if (model.coverMiddle != nil) {
                imageView.kf.setImage(with: URL(string: model.coverMiddle!))
            }
            titleLabel.text = model.nickname
            subLabel.text = model.name
            categoryL.text = model.categoryName
        }
    }
}

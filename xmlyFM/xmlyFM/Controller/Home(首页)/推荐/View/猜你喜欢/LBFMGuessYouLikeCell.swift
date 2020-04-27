//
//  LBFMGuessYouLikeCell.swift
//  xmlyFM
//
//  Created by Soul on 22/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMGuessYouLikeCell: UICollectionViewCell {
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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
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
    }
    
    var recommendData : LBFMRecommendListModel? {
        didSet {
            
            guard let model = recommendData else { return }
            
            if model.pic != nil {
                imageView.kf.setImage(with: URL(string: model.pic!))
            }
            titleLabel.text = model.title
            subLabel.text = model.subtitle
        }
    }
    
}

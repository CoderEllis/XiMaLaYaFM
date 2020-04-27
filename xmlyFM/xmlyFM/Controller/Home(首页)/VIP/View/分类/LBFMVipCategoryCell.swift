//
//  LBFMVipCategoryCell.swift
//  xmlyFM
//
//  Created by Soul on 25/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMVipCategoryCell: UICollectionViewCell {

    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
    }
    
    var categoryBtnModel: LBFMCategoryBtnModel? {
        didSet {
            guard let model = categoryBtnModel else {return}
            imageView.kf.setImage(with: URL(string: model.coverPath!))
            titleLabel.text = model.title
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

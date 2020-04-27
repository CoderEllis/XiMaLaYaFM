

//
//  LBFMRadioCategoriesCell.swift
//  xmlyFM
//
//  Created by Soul on 24/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMRadioCategoriesCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.width.equalToSuperview()
        }
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.top.equalTo(7.5)
            make.centerX.equalToSuperview()
        }
    }
    
    var dataSource: String? {
        didSet {
            guard let str = dataSource else { return }
            imageView.image = UIImage(named: " ")
            titleLabel.text = nil
            if (str.contains(".png")) {
                imageView.image = UIImage(named: str)
            }else {
                titleLabel.text = str
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

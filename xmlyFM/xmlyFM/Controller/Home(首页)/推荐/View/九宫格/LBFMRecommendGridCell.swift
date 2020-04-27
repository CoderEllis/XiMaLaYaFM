//
//  LBFMRecommendGridCell.swift
//  xmlyFM
//
//  Created by Soul on 22/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMRecommendGridCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUI() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(imageView.snp.bottom).offset(5)
        }
    }
    var square : LBFMSquareModel? {
        didSet {
            guard let model = square else {
                return
            }
            imageView.kf.setImage(with: URL(string: model.coverPath!))
            titleLabel.text = model.title
        }
    }
    
    
}

//
//  LBFMFindAttentionPicCell.swift
//  xmlyFM
//
//  Created by Soul on 21/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMFindAttentionPicCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupLayout() {
        addSubview(imageView)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    var picModel : LBFMFindAPicInfos? {
        didSet {
            guard let model = picModel else {
                return
            }
            imageView.kf.setImage(with: URL(string: model.originUrl!))
        }
    }
    
    
}

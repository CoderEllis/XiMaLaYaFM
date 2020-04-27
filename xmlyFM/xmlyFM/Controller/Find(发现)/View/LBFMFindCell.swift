
//
//  LBFMFindCell.swift
//  xmlyFM
//
//  Created by Soul on 20/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMFindCell: UICollectionViewCell {
    
    private lazy var picView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI() {
        addSubview(picView)
        picView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(45)
            make.centerX.equalToSuperview()
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(picView.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.left.right.equalToSuperview()
        }
    }
    
    var dataString : String? {
        didSet {
            titleLabel.text = dataString
            picView.image = UIImage(named: dataString!)
        }
    }
    
}

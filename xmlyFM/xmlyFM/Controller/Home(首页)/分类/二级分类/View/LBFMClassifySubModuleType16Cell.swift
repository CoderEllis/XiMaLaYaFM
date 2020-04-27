//
//  LBFMClassifySubModuleType16Cell.swift
//  xmlyFM
//
//  Created by Soul on 31/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMClassifySubModuleType16Cell: UICollectionViewCell {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
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
    
    var classifyVerticalModel: LBFMClassifyVerticalModel? {
        didSet {
            guard let model = classifyVerticalModel else {return}
            imageView.kf.setImage(with: URL(string: model.coverMiddle!))
            titleLabel.text = model.name
            subLabel.text = model.nickname
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

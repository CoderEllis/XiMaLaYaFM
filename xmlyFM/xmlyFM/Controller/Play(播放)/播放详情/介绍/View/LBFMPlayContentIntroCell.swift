//
//  LBFMPlayContentIntroCell.swift
//  xmlyFM
//
//  Created by Soul on 29/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMPlayContentIntroCell: UITableViewCell {
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "内容简介"
        return label
    }()
    // 内容详情
    private lazy var subLabel:LBFMCustomLabel = {
        let label = LBFMCustomLabel()
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    func setUpUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.right.equalToSuperview()
            make.height.equalTo(30)
        }
        addSubview(subLabel)
        subLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.right.equalToSuperview().offset(-15)
        }
    }
    
    var playDetailAlbumModel : LBFMPlayDetailAlbumModel? {
        didSet {
            guard let model = playDetailAlbumModel else {
                return
            }
            subLabel.text = model.shortIntro
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

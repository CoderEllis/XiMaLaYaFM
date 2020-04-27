
//
//  LBFMOneKeyListenLTCell.swift
//  xmlyFM
//
//  Created by Soul on 20/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMOneKeyListenLTCell: UITableViewCell {
    
    // 竖线
    var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = LBFMButtonColor
        view.isHidden = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    func setUpLayout() {
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.equalTo(4)
            make.height.equalTo(20)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(30)
            make.left.equalTo(lineView.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    ///设置数据
    var channelClassInfo : ChannelClassInfoModel? {
        didSet {
            guard let model = channelClassInfo else {
                return
            }
            titleLabel.text = model.className
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

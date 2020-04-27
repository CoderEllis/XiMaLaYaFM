//
//  LBFMRadioHeaderView.swift
//  xmlyFM
//
//  Created by Soul on 24/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMRadioHeaderView: UICollectionReusableView {
    // 标题
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private var moreBtn:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("更多 >", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    func setUpLayout(){
        addSubview(titleLabel)
        titleLabel.text = "最热有声读物"
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        addSubview(moreBtn)
        moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(15)
            make.top.equalTo(15)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
    
    var titStr: String? {
        didSet{
            guard let string = titStr else {return}
            titleLabel.text = string
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

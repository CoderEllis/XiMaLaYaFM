//
//  LBFMClassifySubHeaderView.swift
//  xmlyFM
//
//  Created by Soul on 29/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMClassifySubHeaderView: UICollectionReusableView {
    // 标题
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    // 更多
    private var moreBtn:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("更多 >", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    // 收听全部
    private var allBtn:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "category_rec_play_all_122x46_"), for: .normal)
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    // 布局
    func setUpLayout(){
        addSubview(titleLabel)
        titleLabel.text = "猜你喜欢"
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.width.equalTo(200)
            make.top.equalTo(5)
            make.height.equalTo(30)
        }
        
        addSubview(moreBtn)
        moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(15)
            make.top.equalTo(5)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        addSubview(allBtn)
        allBtn.layer.masksToBounds = true
        allBtn.layer.cornerRadius = 15
        allBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.equalTo(5)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
    }
    
    var classifyCategoryContents:LBFMClassifyCategoryContentsList?{
        didSet {
            guard let model = classifyCategoryContents else {return}
            titleLabel.text = model.title
            if model.moduleType == 19 {
                moreBtn.isHidden = true
                allBtn.isHidden = false
            }else {
                moreBtn.isHidden = false
                allBtn.isHidden = true
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

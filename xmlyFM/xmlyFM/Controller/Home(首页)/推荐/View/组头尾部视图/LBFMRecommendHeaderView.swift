//
//  LBFMRecommendHeaderView.swift
//  xmlyFM
//
//  Created by Soul on 22/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

// 创建闭包 - OC中的block
typealias LBFMHeaderMoreBtnClick = () ->Void
class LBFMRecommendHeaderView: UICollectionReusableView {
    var headerMoreBtnClick : LBFMHeaderMoreBtnClick?
    // 标题
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        return titleLabel
    }()
    
    // 副标题
    private lazy var subLabel: UILabel = {
        let subLabel = UILabel()
        subLabel.font = UIFont.systemFont(ofSize: 15)
        subLabel.textAlignment = .right
        subLabel.textColor = UIColor.lightGray
        return subLabel
    }()
    
     // 更多
    private lazy var moreButton: UIButton = {
        let moreButton = UIButton(type: UIButton.ButtonType.custom)
        moreButton.setTitle("更多 >", for: .normal)
        moreButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        moreButton.addTarget(self, action: #selector(moreButtonClick(_:)), for: .touchUpInside)
        return moreButton
    }()
    
    @objc func moreButtonClick(_ moreButton:UIButton) {
        // 闭包回调
        guard let headerMoreBtnClick = headerMoreBtnClick else { return }
        headerMoreBtnClick()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeaderView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupHeaderView() {
        addSubview(titleLabel)
        titleLabel.text = "猜你喜欢"
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(15)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        addSubview(subLabel)
        subLabel.text = "副标题"
        subLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right)
            make.height.top.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-100)
        }
        
        addSubview(moreButton)
        moreButton.snp.makeConstraints { (make) in
            make.right.equalTo(15)
            make.top.equalTo(15)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
    
    var homeRecommendList : LBFMRecommendModel? {
        didSet {
            guard let model = homeRecommendList else {
                return
            }
            if model.title != nil {
                titleLabel.text = model.title
            } else {
                titleLabel.text = "猜你喜欢"
            }
            
        }
    }
    
    
}

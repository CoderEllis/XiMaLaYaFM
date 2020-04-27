

//
//  LBFMListenFooterView.swift
//  xmlyFM
//
//  Created by Soul on 19/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

/// 添加按钮点击代理方法
protocol LBFMListenFooterViewDelegate: NSObjectProtocol {
    func listenFooterAddBtnClick()
}

class LBFMListenFooterView: UIView {
    weak var delegate : LBFMListenFooterViewDelegate?
    
    lazy var addButton : UIButton = {
       let button = UIButton(type: UIButton.ButtonType.custom)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(addButtonClick), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func addButtonClick() {
        delegate?.listenFooterAddBtnClick()
    }
    
    func setUpLayout() {
        addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.centerX.equalToSuperview()
        }
        addButton.layer.masksToBounds = true
        addButton.layer.cornerRadius = 20
    }
    var listenFooterViewTitle : String? {
        didSet {
            addButton.setTitle(listenFooterViewTitle, for: .normal)
        }
    }
    
    
}

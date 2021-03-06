//
//  LBFMPlayDetailProgramHeaderView.swift
//  xmlyFM
//
//  Created by Soul on 29/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMPlayDetailProgramHeaderView: UIView {

    private lazy var playBtn:UIButton = {
        // 收听全部
        let button = UIButton.init(type: .custom)
        button.setTitle("收听全部", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setImage(UIImage(named: "play"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        button.backgroundColor = LBFMButtonColor
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    func setUpLayout(){
        addSubview(playBtn)
        playBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.width.equalTo(80)
            make.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

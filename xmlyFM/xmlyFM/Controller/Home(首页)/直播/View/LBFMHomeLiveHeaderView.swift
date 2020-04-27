//
//  LBFMHomeLiveHeaderView.swift
//  xmlyFM
//
//  Created by Soul on 24/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import SwiftMessages

/// 添加cell点击代理方法
protocol LBFMHomeLiveHeaderViewDelegate:NSObjectProtocol {
    func homeLiveHeaderViewCategoryBtnClick(button:UIButton)
}

class LBFMHomeLiveHeaderView: UICollectionReusableView {
    weak var delegate : LBFMHomeLiveHeaderViewDelegate?
    
    private var btnArray = NSMutableArray()
    private var lineView : UIView = {
        let view = UIView()
        view.backgroundColor = LBFMButtonColor
        return view
    }()
    
    private var moreBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("更多 >", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.addTarget(self, action: #selector(moreBtnClick), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let num = ["热门","情感","有声","新秀","二次元"]
        let margin:CGFloat = 50
        for index in 0..<num.count {
            let btn = UIButton.init(type: .custom)
            btn.frame = CGRect(x:margin*CGFloat(index),y:2.5,width:margin,height:25)
            btn.setTitle(num[index], for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.setTitleColor(UIColor.lightGray, for: .normal)
            btn.tag = index+1000
            if btn.tag == 1000 {
                btn.setTitleColor(LBFMButtonColor, for: .normal)
                self.lineView.frame = CGRect(x:margin * CGFloat(btn.tag - 1000)+12.5,y:30,width:margin/2,height:2)
            }else {
                btn.setTitleColor(UIColor.lightGray, for: .normal)
            }
            self.btnArray.add(btn)
            btn.addTarget(self, action: #selector(btnClick(button:)), for: .touchUpInside)
            self.addSubview(btn)
        }
        
        self.addSubview(self.lineView)
        self.addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(25)
            make.width.equalTo(50)
            make.top.equalTo(2.5)
        }
        
    }
    
    @objc func btnClick(button:UIButton) {
        let margin:CGFloat = 50
        self.lineView.frame = CGRect(x:margin*CGFloat(button.tag-1000)+12.5,y:30,width:margin/2,height:2)
        for btn in self.btnArray {
            if (btn as AnyObject).tag == button.tag {
                (btn as AnyObject).setTitleColor(LBFMButtonColor, for: .normal)
            }else {
                (btn as AnyObject).setTitleColor(UIColor.lightGray, for: .normal)
            }
        }
        delegate?.homeLiveHeaderViewCategoryBtnClick(button: button)
    }
    
    @objc func moreBtnClick(){
        
        let warning = MessageView.viewFromNib(layout: .cardView)
        warning.configureTheme(.warning)
        warning.configureDropShadow()
        
        let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
        warning.configureContent(title: "Warning", body: "暂时没有此功能", iconText: iconText)
        warning.button?.isHidden = true
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        SwiftMessages.show(config: warningConfig, view: warning)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

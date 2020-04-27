//
//  LBFMMineHeaderView.swift
//  xmlyFM
//
//  Created by Soul on 19/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

/// 添加按钮点击代理方法
protocol LBFMMineHeaderViewDelegate : NSObjectProtocol {
    func shopBtnClick(tag:Int)
}


// 我的页面顶部headerview
class LBFMMineHeaderView: UIView {

    weak var delegate : LBFMMineHeaderViewDelegate?
    
    /// 上下浮动的vip标签view
    private lazy var animationView : LBFMVipAnimationView = {
        let animationView = LBFMVipAnimationView()
        return animationView
    }()
    
    ///头像
    private lazy var imageView : UIView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tom")
        return imageView
    }()
    
    ///昵称
    private lazy var nickName : UILabel = {
        let lable = UILabel()
        lable.text = "JCSON先生"
        return lable
    }()
    
    ///粉丝
    private lazy var fansLabel : UILabel = {
        let label = UILabel()
        label.text = "粉丝  100万"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    /// 关注
    private lazy var attentionL : UILabel = {
        let label = UILabel()
        label.text = "关注  7"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    /// 解锁
    private lazy var clearLabel : UILabel = {
        let label = UILabel()
        label.text = "已听9分钟，满3小时解锁>"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    /// shopView
    private lazy var shopView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    /// shopView上细线
    private lazy var lineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 240.0 / 255.0, green: 240.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setUpLayout()
        setUpShopView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpLayout() {
        
        addSubview(animationView)
        animationView.layer.masksToBounds = true 
        animationView.layer.cornerRadius = 10
        animationView.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(80)
            make.top.equalTo(120)
            make.right.equalToSuperview().offset(-20)
        }
        /// vip动画view的旋转角度
        animationView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 12)
        
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(80)
            make.width.height.equalTo(80)
        }
        
        addSubview(nickName)
        nickName.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(10)
            make.top.equalTo(imageView.snp.top).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        addSubview(fansLabel)
        fansLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nickName)
            make.bottom.equalTo(imageView.snp.bottom).offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        addSubview(attentionL)
        attentionL.snp.makeConstraints { (make) in
            make.left.equalTo(fansLabel.snp.right).offset(10)
            make.bottom.width.height.equalTo(fansLabel)
        }
        
        addSubview(clearLabel)
        clearLabel.layer.borderColor = UIColor.gray.cgColor
        clearLabel.layer.borderWidth = 0.5
        clearLabel.layer.masksToBounds = true
        clearLabel.layer.cornerRadius = 13
        clearLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageView)
            make.bottom.equalToSuperview().offset(-110)
            make.height.equalTo(26)
            make.width.equalTo(220)
        }
        
        addSubview(shopView)
        shopView.snp.makeConstraints { (make) in
            make.right.left.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
        
        shopView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.right.left.top.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    func setUpShopView() {
        let margin: CGFloat = ScreenWidth / 10
        let titleArray = ["已购","优惠券","喜点","直播喜钻","我的钱包"]
        let dataArray = ["10","2","88","66","钱包"]
        for index in 0...4 {
            let button = UIButton.init(frame: CGRect(x: margin*CGFloat(index)*2+margin/2, y: 10, width: margin, height: margin))
            if index == 4 {
                button.setImage(UIImage(named: dataArray[index]), for: .normal)
            } else {
                button.setTitle(dataArray[index], for: .normal)
                button.setTitleColor(UIColor.black, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
            }
            shopView.addSubview(button)
            
            let titleLabel = UILabel()
            titleLabel.textAlignment = .center
            titleLabel.text = titleArray[index]
            titleLabel.textColor = UIColor.gray
            titleLabel.font = UIFont.systemFont(ofSize: 15)
            
            addSubview(titleLabel)
            titleLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(button)
                make.width.equalTo(margin+30)
                make.top.equalTo(button.snp.bottom).offset(10)
            }
            
            button.tag = index
            button.addTarget(self, action: #selector(gridBtnClick(button:)), for: .touchUpInside)
            
        }
        
        
    }
    
    /// 开始动画
    func setAnimationViewAnimation() {
        let yorig: CGFloat = 100.0 + 64
        let opts: UIView.AnimationOptions = [.autoreverse, .repeat]
        UIView.animate(withDuration: 1, delay: 1, options: opts, animations: { 
            self.animationView.center.y -= 20
        }) { (_) in
            self.animationView.center.y = yorig
        }
    }
    
    
    /// 停止动画
    func stopAnimationViewAnimation() {
        animationView.layer.removeAllAnimations()
    }
    
     /// - 购买等按钮点击事件
    @objc func gridBtnClick(button : UIButton) {
        delegate?.shopBtnClick(tag: button.tag)
    }
}

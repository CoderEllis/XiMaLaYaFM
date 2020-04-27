

//
//  LBFMMineMakeCell.swift
//  xmlyFM
//
//  Created by Soul on 19/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMMineMakeCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //布局
    func setUpLayout() {
        let margin:CGFloat = ScreenWidth / 8
        let titleArray = ["我要录音","我要直播","我的作品","主播工作台"]
        let imageArray = ["麦克风","直播","视频","工作台"]
        for index in 0...3 {
            let button = UIButton.init(frame: CGRect(x: margin*CGFloat(index)*2+margin/2, y: 10, width: margin, height: margin))
            button.setImage(UIImage(named: imageArray[index]), for: .normal)
            addSubview(button)
            
            let titleLabel = UILabel()
            titleLabel.textAlignment = .center
            titleLabel.text = titleArray[index]
            titleLabel.font = UIFont.systemFont(ofSize: 15)
            if index == 0 {
                titleLabel.textColor = UIColor(red: 213.0 / 255.0, green: 54.0 / 255.0, blue: 13.0 / 255.0, alpha: 1.0)
                let waveView = LBFMCVLayerView.init(frame: CGRect(x: margin*CGFloat(index)*2 + margin/2 , y: 10, width: margin, height: margin))
                waveView.isUserInteractionEnabled = false
                waveView.center = button.center
                addSubview(waveView)
                waveView.starAnimation()  // 开始动画
            } else {
                titleLabel.textColor = UIColor.gray
            }
            addSubview(titleLabel)
            titleLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(button)
                make.width.equalTo(margin+30)
                make.top.equalTo(margin+15)
            }
            
            button.tag = index
            button.addTarget(self, action: #selector(gridBtnClick(button:)), for: .touchUpInside)
        }
        
        
    }

    
    /// - 购买等按钮点击事件
    @objc func gridBtnClick(button : UIButton) {
        print(button.tag)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

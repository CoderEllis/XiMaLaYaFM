//
//  LBFMListenController.swift
//  xmlyFM
//
//  Created by Soul on 19/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import LTScrollView

class LBFMListenController: UIViewController {
    
    // 头部 - headerView
    private lazy var headerView : LBFMListenHeaderView = {
        let view = LBFMListenHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 120))
        return view
    }()
    
    // 添加控制器
    private lazy var viewControllers : [UIViewController] = {
        let listenSubscibeVC = LBFMListenSubscibeController()
        let listenChannelVC = LBFMListenChannelController()
        let listenRecommendVC = LBFMListenRecommendController()
        return [listenSubscibeVC,listenChannelVC,listenRecommendVC]
    }()
    
    
    // 添加l控制器上部标题
    private lazy var titles: [String] = {
        return ["订阅", "一键听", "推荐"]
    }()
    
//    lazy var advancedManager = UIScrollView
    
    
    
    // 导航栏左边按钮
    private lazy var leftBarButton : UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "msg"), for: .normal)
        button.addTarget(self, action: #selector(leftBarButtonClick), for: .touchUpInside)
        return button
    }()
    
    // 导航栏由边按钮
    private lazy var rightBarButton : UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "搜索"), for: .normal)
        button.addTarget(self, action: #selector(leftBarButtonClick), for: .touchUpInside)
        return button
    }()
    
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.isAverage = true
        layout.sliderWidth = 80
        layout.titleViewBgColor = UIColor.white
        layout.titleColor = UIColor(r: 178, g: 178, b: 178)
        layout.titleSelectColor = UIColor(r: 16, g: 16, b: 16)
        layout.bottomLineColor = UIColor.red
        layout.sliderHeight = 56
        /* 更多属性设置请参考 LTLayout 中 public 属性说明 */
        return layout
    }()
    
    private lazy var advancedManager : LTAdvancedManager = {
        let statusBarH = UIApplication.shared.statusBarFrame.size.height
        let advancedManager = LTAdvancedManager(frame: CGRect(x: 0, y: LBFMNavBarHeight, width: ScreenWidth, height: ScreenHeight - LBFMNavBarHeight), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout, headerViewHandle: { [weak self]  in
            guard let strongSelf = self else { return UIView() }
            let headerView = strongSelf.headerView
            return headerView
        })
        /* 设置代理 监听滚动 */
        advancedManager.delegate = self
        /* 设置悬停位置 */
        // advancedManager.hoverY = - LBFMNavBarHeight
        /* 点击切换滚动过程动画 */
        // advancedManager.isClickScrollAnimation = true
        /* 代码设置滚动到第几个位置 */
        // advancedManager.scrollToIndex(index: viewControllers.count - 1)
        return advancedManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(advancedManager)
        advancedManagerConfig()
    }
    
    deinit {
        print(" --- deinit --- ")
    }
    
    // 导航栏左边消息点击事件
    @objc func leftBarButtonClick() {
        print("左边按钮")
    }
    // 导航栏左边消息点击事件
    @objc func rightBarButtonClick() {
        print("右边按钮")
    }
    
}

extension LBFMListenController : LTAdvancedScrollViewDelegate{
    // 具体使用请参考以下
    private func advancedManagerConfig() {
        // 选中事件
        advancedManager.advancedDidSelectIndexHandle = {
            print("选中了 -> \($0)")
        }
    }
    func glt_scrollViewOffsetY(_ offsetY: CGFloat) {
        
    }
}

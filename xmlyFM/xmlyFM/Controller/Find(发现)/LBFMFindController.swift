//
//  LBFMFindController.swift
//  xmlyFM
//
//  Created by Soul on 19/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import LTScrollView

class LBFMFindController: UIViewController {
    
    // - headerView
    private lazy var headerView : LBFMFindHeaderView = {
        let view = LBFMFindHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 190))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var viewControllers : [UIViewController] = {
        let findAttentionVC = LBFMFindAttentionController()
        let findRecommendVC = LBFMFindRecommendController()
        let findDuDYVC = LBFMFindDudController()
        return [findAttentionVC, findRecommendVC, findDuDYVC]
    }()
    
    private lazy var titles: [String] = {
        return ["关注动态", "推荐动态", "趣配音"]
    }()
    
    private lazy var layout : LTLayout = {
        let layout = LTLayout()
        layout.isAverage = true
        layout.sliderWidth = 80
        layout.sliderHeight = 56
        layout.titleViewBgColor = UIColor.white
        layout.titleColor = UIColor(r: 178, g: 178, b: 178)
        layout.titleSelectColor = UIColor(r: 16, g: 16, b: 16)
        layout.bottomLineColor = UIColor.red
        return layout
    }()
    
    private lazy var advancedManager : LTAdvancedManager = {
        let statusBarH = UIApplication.shared.statusBarFrame.height
        let advancedManager = LTAdvancedManager(frame: CGRect(x: 0, y: LBFMNavBarHeight, width: ScreenWidth, height: ScreenHeight - LBFMNavBarHeight), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout, headerViewHandle: { [weak self] in
            guard let strongSelf = self else { return UIView() }
            let headerView = strongSelf.headerView
            return headerView
        })
        /* 设置代理 监听滚动 */
        advancedManager.delegate = self
        /* 设置悬停位置 */
        // advancedManager.hoverY = navigationBarHeight
        /* 点击切换滚动过程动画 */
        // advancedManager.isClickScrollAnimation = true
        /* 代码设置滚动到第几个位置 */
        // advancedManager.scrollToIndex(index: viewControllers.count - 1)
        return advancedManager
    }() 
    
    private lazy var leftBarButton : UIButton = {
        let leftBtn = UIButton(type: UIButton.ButtonType.custom)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftBtn.setImage(UIImage(named: "msg"), for: .normal)
        leftBtn.addTarget(self, action: #selector(leftBarButtonClick), for: .touchUpInside)
        return leftBtn
    }()
    
    private lazy var rightBarButton : UIButton = {
        let leftBtn = UIButton(type: UIButton.ButtonType.custom)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftBtn.setImage(UIImage(named: "搜索"), for: .normal)
        leftBtn.addTarget(self, action: #selector(rightBarButtonClick), for: .touchUpInside)
        return leftBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: rightBarButton)
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(advancedManager)
        advancedManagerConfig()
    }
    

    

}


// MARK: - 导航按钮事件
extension LBFMFindController{
    @objc func leftBarButtonClick() {
        
    }
    
    @objc func rightBarButtonClick() {
        
    }
}


extension LBFMFindController: LTAdvancedScrollViewDelegate {
    func advancedManagerConfig() {
        // 选中事件
        advancedManager.advancedDidSelectIndexHandle = {
            print("选中了->>>>\($0)")
        }
    }
    
    func glt_scrollViewOffsetY(_ offsetY: CGFloat) {
        
    }
}

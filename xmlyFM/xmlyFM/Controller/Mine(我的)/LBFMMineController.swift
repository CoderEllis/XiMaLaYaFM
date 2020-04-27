//
//  LBFMMineController.swift
//  xmlyFM
//
//  Created by Soul on 19/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
let kNavBarBottom = WRNavigationBar.navBarBottom()


class LBFMMineController: UIViewController {
    private let LBFMMineMakeCellID = "LBFMMineMakeCell"
    private let LBFMMineShopCellID = "LBFMMineShopCell"
    
    private lazy var dataSource : Array = {
        return [
            [["icon":"钱数", "title": "分享赚钱"],["icon":"沙漏", "title": "免流量服务"]],
            [["icon":"扫一扫", "title": "扫一扫"],["icon":"月亮", "title": "夜间模式"]],
            [["icon":"意见反馈", "title": "帮助与反馈"]]] 
    }()
    
    // 懒加载顶部头视图
    private lazy var headerView : LBFMMineHeaderView = {
        let view = LBFMMineHeaderView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 300))
        view.delegate = self
        return view
    }()
    
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .plain)
        tableView.contentInset = UIEdgeInsets(top: -CGFloat(kNavBarBottom), left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = LBFMDownColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(LBFMMineMakeCell.self, forCellReuseIdentifier: LBFMMineMakeCellID)
        tableView.tableHeaderView = headerView
        return tableView
    }()
    
    // - 导航栏左边按钮
    private lazy var leftBarButton : UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "msg"), for: .normal)
        button.addTarget(self, action: #selector(leftBarButtonClick), for: .touchUpInside)
        return button
    }()
    
    // - 导航栏右边按钮
    private lazy var rightBarButton : UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "set"), for: .normal)
        button.addTarget(self, action: #selector(rightBarButtonClick), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置导航栏颜色
        navBarBarTintColor = UIColor.init(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1.0)
        // 设置初始导航栏透明度
        navBarBackgroundAlpha = 0
        navigationItem.title = "我的"
        view.backgroundColor = UIColor.white
        view.addSubview(self.tableView)
        
        // 导航栏左右item
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
    }
    

    // - 导航栏左边消息点击事件
    @objc func leftBarButtonClick() {
        
    }
    // - 导航栏右边设置点击事件
    @objc func rightBarButtonClick() {
        let setVC = LBFMMineSetController()
        self.navigationController?.pushViewController(setVC, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        headerView.stopAnimationViewAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerView.setAnimationViewAnimation()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension LBFMMineController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 || section == 2 {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 100
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell :LBFMMineMakeCell = tableView.dequeueReusableCell(withIdentifier: LBFMMineMakeCellID, for: indexPath) as! LBFMMineMakeCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .none
            let sectionArray = dataSource[indexPath.section-1]
            let dict: [String: String] = sectionArray[indexPath.row]
            cell.imageView?.image = UIImage(named: dict["icon"] ?? "")
            cell.textLabel?.text = dict["title"]
            if indexPath.section == 3 && indexPath.row == 1 {
                let cellSwitch = UISwitch.init()
                cell.accessoryView = cellSwitch
            }else {
                cell.accessoryType = .disclosureIndicator
            }
            
            return cell
        }       
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.red
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.blue
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY > 0 {
            let alpha = offsetY / CGFloat(kNavBarBottom)
            navBarBackgroundAlpha = alpha
        } else {
            navBarBackgroundAlpha = 0
        }
    }
    
}


// MARK: - 按钮事件代理
extension LBFMMineController : LBFMMineHeaderViewDelegate {
    func shopBtnClick(tag: Int) {
        
    }
    
}

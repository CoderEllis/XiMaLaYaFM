//
//  LBFMFindRecommendController.swift
//  xmlyFM
//
//  Created by Soul on 20/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import LTScrollView

class LBFMFindRecommendController: UIViewController, LTTableViewProtocal{
    private let LBFMFindRecommendCellID = "LBFMFindRecommendCell"
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - LBFMNavBarHeight - LBFMTabBarHeight), self, self, nil)
        tableView.register(LBFMFindRecommendCell.self, forCellReuseIdentifier: LBFMFindRecommendCellID)
        return tableView
    }()
    
    // 懒加载
    lazy var viewModel: LBFMFindRecommendViewModel = {
        return LBFMFindRecommendViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        setupLoadData()
    }
    
    // 加载数据
    func setupLoadData() {
        viewModel.updataBlock = { [unowned self] in
            // 更新列表数据
            self.tableView.reloadData()
        }
        viewModel.refreshDataSource()
    }
    
    
}

extension LBFMFindRecommendController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LBFMFindRecommendCell = tableView.dequeueReusableCell(withIdentifier: LBFMFindRecommendCellID, for: indexPath) as! LBFMFindRecommendCell
        cell.selectionStyle = .none
        cell.streamModel = viewModel.streamList?[indexPath.row]
        return cell
    }
    
    
}


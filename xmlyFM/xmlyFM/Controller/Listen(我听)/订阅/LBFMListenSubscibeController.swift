//
//  LBFMListenSubscibeController.swift
//  xmlyFM
//
//  Created by Soul on 19/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import LTScrollView

private let LBFMListenSubscibeCellID = "LBFMListenSubscibeCell"
class LBFMListenSubscibeController: UIViewController, LTTableViewProtocal {
    private lazy var footerView : LBFMListenFooterView = {
        let view = LBFMListenFooterView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 100))
        view.listenFooterViewTitle = "➕添加订阅"
        view.delegate = self
        return view
    }()
    
    private lazy var tableView : UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 64), self, self, nil)
        tableView.register(LBFMListenSubscibeCell.self, forCellReuseIdentifier: LBFMListenSubscibeCellID)
        tableView.backgroundColor = UIColor(red: 240.0 / 255.0, green: 241.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
        tableView.tableFooterView = footerView
        return tableView
    }()
    
    lazy var viewModel : LBFMListenSubscibeViewModel = {
       return LBFMListenSubscibeViewModel() 
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        setupLoadData()
    }
    
    ///数据
    func setupLoadData() {
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            // 更新列表数据
            self.tableView.reloadData()
        }
        viewModel.refreshDataSource()
    }
}

extension LBFMListenSubscibeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : LBFMListenSubscibeCell = tableView.dequeueReusableCell(withIdentifier: LBFMListenSubscibeCellID, for: indexPath) as! LBFMListenSubscibeCell
        cell.selectionStyle = .none
        cell.albumResults = viewModel.albumResults?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension LBFMListenSubscibeController: LBFMListenFooterViewDelegate{
    func listenFooterAddBtnClick() {
        print("点击了订阅")
    }
    
    
}

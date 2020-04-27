//
//  LBFMListenChannelController.swift
//  xmlyFM
//
//  Created by Soul on 19/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import LTScrollView

class LBFMListenChannelController: UIViewController, LTTableViewProtocal {

    private let LBFMListenChannelCellID = "LBFMListenChannelCell"
    private lazy var footerView : LBFMListenFooterView = {
        let view = LBFMListenFooterView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 100)) 
        view.listenFooterViewTitle = "➕添加频道"
        view.delegate = self
        return view
    }()
    
    private lazy var tableView : UITableView = {
        let  tableView = tableViewConfig(CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 64), self, self, nil)
        tableView.register(LBFMListenChannelCell.self, forCellReuseIdentifier: LBFMListenChannelCellID)
        tableView.separatorStyle = .none
        tableView.tableFooterView = footerView
        tableView.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
        return tableView
    }()
    
    private var viewModel : LBFMListenChannelViewModel = {
        return  LBFMListenChannelViewModel()
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        setupLoadData()
    }
    
    func setupLoadData() {
        viewModel.updataBlock = { [unowned self] in
            // 更新列表数据
            self.tableView.reloadData()
        }
        viewModel.refreshDataSource()
    }

    

}
extension LBFMListenChannelController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LBFMListenChannelCell = tableView.dequeueReusableCell(withIdentifier: LBFMListenChannelCellID, for: indexPath) as! LBFMListenChannelCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
        cell.channelClassInfo = viewModel.channelResults?[indexPath.row]
        return cell
    }
    
    
}

extension LBFMListenChannelController: LBFMListenFooterViewDelegate {
    func listenFooterAddBtnClick() {
        let view = LBFMListenMoreChannelController()
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
}

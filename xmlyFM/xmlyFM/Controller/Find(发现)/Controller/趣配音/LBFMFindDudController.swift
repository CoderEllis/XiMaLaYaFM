//
//  LBFMFindDudController.swift
//  xmlyFM
//
//  Created by Soul on 20/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import LTScrollView
import HandyJSON
import SwiftyJSON

class LBFMFindDudController: UIViewController, LTTableViewProtocal {
    private var findDudList: [LBFMFindDudModel]?
    private let LBFMFindDudCellID = "FindDudCell"
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - LBFMNavBarHeight - LBFMTabBarHeight), self, self, nil)
        tableView.register(LBFMFindDudCell.self, forCellReuseIdentifier: LBFMFindDudCellID)
        tableView.separatorStyle = .none
        return tableView
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
    
    
    func setupLoadData() {
        let path = Bundle.main.path(forResource: "FindDud", ofType: "json")
        let jsonData = NSData(contentsOfFile: path!)
        let json = JSON(jsonData!)
        if let mappedObject = JSONDeserializer<LBFMFMFindDudModel>.deserializeFrom(json: json.description) {
            self.findDudList = mappedObject.data
            self.tableView.reloadData()
        }
        
    }
}

extension LBFMFindDudController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return findDudList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LBFMFindDudCell = tableView.dequeueReusableCell(withIdentifier: LBFMFindDudCellID, for: indexPath) as! LBFMFindDudCell
        cell.selectionStyle = .none
        cell.findDudModel = findDudList?[indexPath.row]
        return cell
    }
    
    
}

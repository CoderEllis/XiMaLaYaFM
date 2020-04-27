//
//  LBFMPlayDetailIntroController.swift
//  xmlyFM
//
//  Created by Soul on 29/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import LTScrollView

class LBFMPlayDetailIntroController: UIViewController, LTTableViewProtocal {
    private var playDetailAlbum:LBFMPlayDetailAlbumModel?
    private var playDetailUser:LBFMPlayDetailUserModel?
    
    private let LBFMPlayContentIntroCellID = "LBFMPlayContentIntroCell"
    private let LBFMPlayAnchorIntroCellID  = "LBFMPlayAnchorIntroCell"
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:ScreenWidth, height: ScreenHeight), self, self, nil)
        tableView.register(LBFMPlayContentIntroCell.self, forCellReuseIdentifier: LBFMPlayContentIntroCellID)
        tableView.register(LBFMPlayAnchorIntroCell.self, forCellReuseIdentifier: LBFMPlayAnchorIntroCellID)
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
    }
    
    /// 内容简介model
    var playDetailAlbumModel : LBFMPlayDetailAlbumModel? {
        didSet {
            guard let model = playDetailAlbumModel else {
                return
            }
            playDetailAlbum = model
            // 防止刷新分区的时候界面闪烁
            UIView.performWithoutAnimation { 
                self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .none)
            }
        }
    }
    
    /// 主播简介model
    var playDetailUserModel : LBFMPlayDetailUserModel? {
        didSet {
            guard let model = playDetailUserModel else {
                return
            }
            playDetailUser = model
            UIView.performWithoutAnimation { 
                self.tableView.reloadSections(NSIndexSet(index: 1) as IndexSet, with: .none)
            }
        }
        
    }
    

}


extension LBFMPlayDetailIntroController: UITableViewDelegate , UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:LBFMPlayContentIntroCell = tableView.dequeueReusableCell(withIdentifier: LBFMPlayContentIntroCellID, for: indexPath) as! LBFMPlayContentIntroCell
            cell.playDetailAlbumModel = playDetailAlbum
            return cell
        } else {
            let cell:LBFMPlayAnchorIntroCell = tableView.dequeueReusableCell(withIdentifier: LBFMPlayAnchorIntroCellID, for: indexPath) as! LBFMPlayAnchorIntroCell
            cell.playDetailUserModel = playDetailUser
            return cell
        }
    }
    
    
}

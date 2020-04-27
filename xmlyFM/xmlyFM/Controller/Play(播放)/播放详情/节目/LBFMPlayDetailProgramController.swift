//
//  LBFMPlayDetailProgramController.swift
//  xmlyFM
//
//  Created by Soul on 29/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import LTScrollView

class LBFMPlayDetailProgramController: UIViewController, LTTableViewProtocal {
    private var playDetailTracks:LBFMPlayDetailTracksModel?
    
    private let LBFMPlayDetailProgramCellID = "LBFMPlayDetailProgramCell"
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y:0, width:ScreenWidth, height: ScreenHeight), self, self, nil)
        tableView.register(LBFMPlayDetailProgramCell.self, forCellReuseIdentifier: LBFMPlayDetailProgramCellID)
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
    
    var playDetailTracksModel : LBFMPlayDetailTracksModel? {
        didSet {
            guard let model = playDetailTracksModel else {
                return
            }
            playDetailTracks = model
            tableView.reloadData()
        }
        
    }
    


}

extension LBFMPlayDetailProgramController: UITableViewDelegate,  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playDetailTracks?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LBFMPlayDetailProgramCell = tableView.dequeueReusableCell(withIdentifier: LBFMPlayDetailProgramCellID, for: indexPath) as! LBFMPlayDetailProgramCell
        cell.playDetailTracksList = playDetailTracks?.list?[indexPath.row]
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumId = playDetailTracks?.list?[indexPath.row].albumId ?? 0
        let trackUid = playDetailTracks?.list?[indexPath.row].trackId ?? 0
        let uid = playDetailTracks?.list?[indexPath.row].uid ?? 0
        let vc = LBFMNavigationController.init(rootViewController: LBFMPlayController(albumId: albumId, trackUid: trackUid, uid: uid))
        present(vc, animated: true, completion: nil)
        
    }
    
}

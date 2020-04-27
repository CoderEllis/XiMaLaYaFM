//
//  LBFMFindHeaderView.swift
//  xmlyFM
//
//  Created by Soul on 20/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMFindHeaderView: UIView {
    // - 发现首页的九宫格分类按钮数据源没抓到，随便搞下
    //    let imageArray = [
    //        "http://fdfs.xmcdn.com/group45/M08/74/91/wKgKlFtVs-iBg01bAAAmze4KwRQ177.png",
    //        "http://fdfs.xmcdn.com/group48/M0B/D9/96/wKgKlVtVs9-TQYseAAAsVyb1apo685.png",
    //        "http://fdfs.xmcdn.com/group48/M0B/D9/92/wKgKlVtVs9SwvFI6AAAdwAr5vEE640.png",
    //        "http://fdfs.xmcdn.com/group48/M02/63/E3/wKgKnFtW37mR9fH7AAAcl17u2wA113.png",
    //        "http://fdfs.xmcdn.com/group46/M09/8A/98/wKgKlltVs3-gubjFAAAxXboXKFE462.png",
    //        "http://fdfs.xmcdn.com/group45/M08/74/91/wKgKlFtVs-iBg01bAAAmze4KwRQ177.png",
    //        "http://fdfs.xmcdn.com/group48/M0B/D9/96/wKgKlVtVs9-TQYseAAAsVyb1apo685.png",
    //        "http://fdfs.xmcdn.com/group48/M0B/D9/92/wKgKlVtVs9SwvFI6AAAdwAr5vEE640.png",
    //        "http://fdfs.xmcdn.com/group48/M02/63/E3/wKgKnFtW37mR9fH7AAAcl17u2wA113.png",
    //        "http://fdfs.xmcdn.com/group46/M09/8A/98/wKgKlltVs3-gubjFAAAxXboXKFE462.png"
    //    ]
    
    let dataArray = ["电子书城","全民朗读","大咖主播","活动","直播微课","听单","游戏中心","边听变看","商城","0元购"]
    private let LBFMFindCellID = "LBFMFindCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: (ScreenWidth - 30) / 5, height: 90)
        let collectionView = UICollectionView(frame: CGRect(x: 15, y: 0, width: ScreenWidth - 30, height: 180), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(LBFMFindCell.self, forCellWithReuseIdentifier: LBFMFindCellID)
        return collectionView
    }()
    
    private lazy var footView : UIView = {
        let view = UIView()
        view.backgroundColor = LBFMDownColor
        return view
    }()
    
    
    func setUI() {
        addSubview(collectionView)
        addSubview(footView)
        footView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(10)
        }
    }
}

extension LBFMFindHeaderView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : LBFMFindCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMFindCellID, for: indexPath) as! LBFMFindCell
        cell.dataString = dataArray[indexPath.row]
        return cell
    }
    
    
}

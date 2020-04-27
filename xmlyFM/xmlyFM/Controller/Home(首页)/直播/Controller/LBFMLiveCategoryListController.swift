//
//  LBFMLiveCategoryListController.swift
//  xmlyFM
//
//  Created by Soul on 24/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class LBFMLiveCategoryListController: UIViewController {
    private var liveList:[LBFMLivesModel]?
    private let LBFMRecommendLiveCellID = "LBFMRecommendLiveCell"
    
    // 外部传值请求接口如此那
    private var channelId = 0
    convenience init(channelId:Int = 0) {
        self.init()
        self.channelId = channelId
    }
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.showsVerticalScrollIndicator = false
        // - 注册不同分区cell
        collection.register(LBFMRecommendLiveCell.self, forCellWithReuseIdentifier:LBFMRecommendLiveCellID)
        collection.uHead = URefreshHeader{ [weak self] in self?.setupLoadData() }
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
        self.collectionView.uHead.beginRefreshing()
        setupLoadData()
    }
    
    func setupLoadData() {
        LBFMHomeLiveAPIProvider.request(LBFMHomeLiveAPI.categoryLiveList(channelId: self.channelId)) { (result) in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<LBFMLivesModel>.deserializeModelArrayFrom(json: json["data"]["homePageVo"]["lives"].description) {
                    self.liveList = mappedObject as? [LBFMLivesModel]
                }
                self.collectionView.uHead.endRefreshing()
                self.collectionView.reloadData()
            }

        }
    }
    
}

// - collectionviewDelegate
extension LBFMLiveCategoryListController: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return liveList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:LBFMRecommendLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMRecommendLiveCellID, for: indexPath) as! LBFMRecommendLiveCell
        cell.liveData = liveList?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:(ScreenWidth - 40)/2,height:230)
    }
}

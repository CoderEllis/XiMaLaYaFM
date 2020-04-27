//
//  LBFMClassifySubContentController.swift
//  xmlyFM
//
//  Created by Soul on 29/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class LBFMClassifySubContentController: UIViewController {
    // - 上页面传过来请求接口必须的参数
    private var keywordId: Int = 0
    private var categoryId: Int = 0
    convenience init(keywordId: Int = 0, categoryId:Int = 0) {
        self.init()
        self.keywordId = keywordId
        self.categoryId = categoryId
    }
    // - 定义接收的数据模型
    private var classifyVerticallist:[LBFMClassifyVerticalModel]?
    
    private let LBFMClassifySubVerticalCellID = "LBFMClassifySubVerticalCell"
    // - 懒加载
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width:ScreenWidth - 15, height:120)
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        // - 注册不同分区cell
        collection.register(LBFMClassifySubVerticalCell.self, forCellWithReuseIdentifier: LBFMClassifySubVerticalCellID)
        collection.uHead = URefreshHeader{ [weak self] in self?.setupLoadData() }
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.top.bottom.equalToSuperview()
        }
        collectionView.uHead.beginRefreshing()
        setupLoadData()
    }
    func setupLoadData() {
    // 分类二级界面其他分类接口请求
        LBFMClassifySubMenuProvider.request(LBFMClassifySubMenuAPI.classifyOtherContentList(keywordId: keywordId, categoryId: categoryId)) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<LBFMClassifyVerticalModel>.deserializeModelArrayFrom(json: json["list"].description) {
                    self.classifyVerticallist = mappedObject as? [LBFMClassifyVerticalModel]
                    self.collectionView.uHead.endRefreshing()
                    self.collectionView.reloadData()
                }
            }
        }
    }

    

}

extension LBFMClassifySubContentController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classifyVerticallist?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:LBFMClassifySubVerticalCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMClassifySubVerticalCellID, for: indexPath) as! LBFMClassifySubVerticalCell
        cell.classifyVerticalModel = classifyVerticallist?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let albumId = classifyVerticallist?[indexPath.row].albumId ?? 0
        let view = LBFMNavigationController.init(rootViewController: LBFMPlayController(albumId: albumId))
        present(view, animated: true, completion: nil)
    }
    
}

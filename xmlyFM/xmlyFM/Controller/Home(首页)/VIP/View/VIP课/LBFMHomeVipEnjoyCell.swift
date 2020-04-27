//
//  LBFMHomeVipEnjoyCell.swift
//  xmlyFM
//
//  Created by Soul on 25/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
/// 添加cell点击代理方法
protocol LBFMHomeVipEnjoyCellDelegate:NSObjectProtocol {
    func homeVipEnjoyCellItemClick(model:LBFMCategoryContents)
}
///VIP课
class LBFMHomeVipEnjoyCell: UITableViewCell {
    weak var delegate : LBFMHomeVipEnjoyCellDelegate?
    
    private var categoryContents:[LBFMCategoryContents]?
    
    private let LBFMVipEnjoyCellID = "LBFMVipEnjoyCell"
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(LBFMVipEnjoyCell.self, forCellWithReuseIdentifier: LBFMVipEnjoyCellID)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setUpLayout(){
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalToSuperview()
        }
    }
    
    var categoryContentsModel:[LBFMCategoryContents]? {
        didSet {
            guard let model = categoryContentsModel else {return}
            categoryContents = model
            collectionView.reloadData()
        }
    }
    
}

extension LBFMHomeVipEnjoyCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return self.recommendList?.count ?? 0
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:LBFMVipEnjoyCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMVipEnjoyCellID, for: indexPath) as! LBFMVipEnjoyCell
        cell.categoryContentsModel = self.categoryContents?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.homeVipEnjoyCellItemClick(model: (self.categoryContents?[indexPath.row])!)
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
    }
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    // item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:(ScreenWidth - 50) / 3,height:self.frame.size.height)
    }
}

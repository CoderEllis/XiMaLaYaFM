//
//  LBFMClassifySubHeaderCell.swift
//  xmlyFM
//
//  Created by Soul on 31/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import FSPagerView

class LBFMClassifySubHeaderCell: UICollectionViewCell {
    private var focus:LBFMFocusModel?
    private var classifyCategoryContentsList:LBFMClassifyCategoryContentsList?
    
    let LBFMClassifySubCategoryCellID = "LBFMClassifySubCategoryCell"
    let FSPagerViewCellID = "FSPagerViewCell"
    // - 懒加载滚动图片浏览器
    private lazy var pagerView : FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval =  3
        pagerView.isInfinite = true
        pagerView.interitemSpacing = 15
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: FSPagerViewCellID)
        return pagerView
    }()
    
    private lazy var layout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    // - 懒加载九宫格分类按钮
    private lazy var gridView: UICollectionView = {
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(LBFMClassifySubCategoryCell.self, forCellWithReuseIdentifier: LBFMClassifySubCategoryCellID)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(pagerView)
        pagerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(150)
        }
        addSubview(gridView)
        gridView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(pagerView.snp.bottom)
            make.height.equalTo(80)
        }
        pagerView.itemSize = CGSize.init(width: ScreenWidth - 60, height: 140)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var focusModel:LBFMFocusModel? {
        didSet{
            guard let model = focusModel else { return }
            self.focus = model
            self.pagerView.reloadData()
        }
    }
    
    var classifyCategoryContentsListModel:LBFMClassifyCategoryContentsList? {
        didSet{
            guard let model = classifyCategoryContentsListModel else {return}
            self.classifyCategoryContentsList = model
            if (self.classifyCategoryContentsList?.list?.count)! == 10 {
                self.layout.scrollDirection = .vertical
            }else {
                self.layout.scrollDirection = .horizontal
            }
            self.gridView.reloadData()
        }
    }
}


// MARK: - 顶部循环滚动视图
extension LBFMClassifySubHeaderCell: FSPagerViewDelegate, FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return focus?.data?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: FSPagerViewCellID, at: index)
        cell.imageView?.kf.setImage(with: URL(string: (focus?.data?[index].cover)!))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        print("点击了\(index)广告按钮")
    }
}


// MARK: - 顶部分类九宫格视图
extension LBFMClassifySubHeaderCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classifyCategoryContentsList?.list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LBFMClassifySubCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMClassifySubCategoryCellID, for: indexPath) as! LBFMClassifySubCategoryCell
        cell.classifyVerticalModel = classifyCategoryContentsList?.list?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    // item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let num:Int = (self.classifyCategoryContentsList?.list?.count)!
        if num <= 6 {
            return CGSize.init(width: ScreenWidth / CGFloat(num), height: 80)
        }else if num < 10 {
            return CGSize.init(width: ScreenWidth / 6, height: 80)
        }else {
            self.gridView.snp.updateConstraints { (make) in
                make.height.equalTo(160)
            }
            return CGSize.init(width: ScreenWidth / 5, height: 80)
        }
    }
}

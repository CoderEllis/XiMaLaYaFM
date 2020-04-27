//
//  LBFMRecommendHeaderCell.swift
//  xmlyFM
//
//  Created by Soul on 22/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import FSPagerView


/// 添加按钮点击代理方法
protocol LBFMRecommendHeaderCellDelegate: NSObjectProtocol {
    func recommendHeaderBtnClick(_ categoryId: String, _ title:String, _ url: String)
    func recommendHeaderBannerClick(_ url: String)
}
class LBFMRecommendHeaderCell: UICollectionViewCell {
    private var focus : LBFMFocusModel?
    private var square : [LBFMSquareModel]?
    private var topBuzzList : [LBFMTopBuzzModel]?
    
    weak var delegate : LBFMRecommendHeaderCellDelegate?
    
    private let LBFMRecommendGridCellID = "LBFMRecommendGridCell"
    private let LBFMRecommendNewsCellID = "LBFMRecommendNewsCell"
    private lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval = 3
        pagerView.isInfinite = true
        pagerView.interitemSpacing = 15
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        return pagerView
    }()
    
    // MARK: - 懒加载九宫格分类按钮
    private lazy var gridView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(LBFMRecommendGridCell.self, forCellWithReuseIdentifier: LBFMRecommendGridCellID)
        collectionView.register(LBFMRecommendNewsCell.self, forCellWithReuseIdentifier: LBFMRecommendNewsCellID)
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayOut()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func setupLayOut() {
        // 分页轮播图
        addSubview(pagerView)
        pagerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(150)
        }
        // 九宫格
        addSubview(gridView)
        gridView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(pagerView.snp.bottom)
            make.height.equalTo(210)
        }
        pagerView.itemSize = CGSize(width: ScreenWidth - 60, height: 140)
    }
    
    /// 数据
    var focusModel : LBFMFocusModel? {
        didSet{
            guard let model = focusModel else { return }
            focus = model
            pagerView.reloadData()
        }
    }
    //九宫格数据
    var squareList : [LBFMSquareModel]? {
        didSet{
            guard let model = squareList else { return }
            square = model
            gridView.reloadData()
        }
    }
    ///滚动头条数据
    var topBuzzListData : [LBFMTopBuzzModel]? {
        didSet{
            guard let model = topBuzzListData else { return }
            topBuzzList = model
            pagerView.reloadData()
        }
    }
    
    
}
//分页广告的数据
extension LBFMRecommendHeaderCell: FSPagerViewDelegate, FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.focus?.data?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.kf.setImage(with: URL(string: (focus?.data?[index].cover)!))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let url: String = focus?.data?[index].link ?? ""
        delegate?.recommendHeaderBannerClick(url)
    }
}

extension LBFMRecommendHeaderCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return square?.count ?? 0
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell: LBFMRecommendGridCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMRecommendGridCellID, for: indexPath) as! LBFMRecommendGridCell
            cell.square = self.square?[indexPath.row]
            return cell
        } else {
            let cell: LBFMRecommendNewsCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMRecommendNewsCellID, for: indexPath) as! LBFMRecommendNewsCell
            cell.topBuzzList = topBuzzList
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: (ScreenWidth - 5)/5, height: 80)
        } else {
            return CGSize(width: ScreenWidth, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let string = square?[indexPath.row].properties?.uri else {
            let categoryId = "0"
            let title = square?[indexPath.row].title ?? ""
            let url = self.square?[indexPath.row].url ?? ""
            delegate?.recommendHeaderBtnClick(categoryId, title, url)
            return
        }
        let categoryId = getUrlCategoryId(string)
        let title = square?[indexPath.row].title ?? ""
        let url = self.square?[indexPath.row].url ?? ""
        delegate?.recommendHeaderBtnClick(categoryId, title, url)
    }
    
    func getUrlCategoryId(_ url: String) -> String {
        // 判断是否有参数
        if !url.contains("?") {
            return ""
        }
        var params = [String: Any]()
        // 截取参数
        let split = url.split(separator: "?")
        let string = split[1]
        // 判断参数是单个参数还是多个参数
        if string.contains("&") {
            // 多个参数，分割参数
            let urlComponents = string.split(separator: "&")
            // 遍历参
            for keyValuePair in urlComponents {
                // 生成Key/Value
                let pairComponents = keyValuePair.split(separator: "=")
                let key:String = String(pairComponents[0])
                let value:String = String(pairComponents[1])
                
                params[key] = value
            }
        } else {
            // 单个参数
            let pairComponents = string.split(separator: "=")
            // 判断是否有值
            if pairComponents.count == 1 {
                return "nil"
            }
            let key:String = String(pairComponents[0])
            let value:String = String(pairComponents[1])
            params[key] = value
        }
        return params["category_id"] as! String
    }
}

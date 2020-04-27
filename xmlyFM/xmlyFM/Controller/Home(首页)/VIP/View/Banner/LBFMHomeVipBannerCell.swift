//
//  LBFMHomeVipBannerCell.swift
//  xmlyFM
//
//  Created by Soul on 25/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import FSPagerView
/// 添加cell点击代理方法
protocol LBFMHomeVipBannerCellDelegate:NSObjectProtocol {
    func homeVipBannerCellClick(url:String)
}

class LBFMHomeVipBannerCell: UITableViewCell {
    weak var delegate : LBFMHomeVipBannerCellDelegate?
    
    var vipBanner: [LBFMFocusImagesData]?
    
    // - 懒加载滚动图片浏览器
    private lazy var pagerView : FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval =  3
        pagerView.isInfinite = true
        pagerView.interitemSpacing = 15
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "LBFMHomeVipBannerCell")
        return pagerView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setView() {
        addSubview(pagerView)
        pagerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        pagerView.itemSize = CGSize.init(width: ScreenWidth-60, height: 140)
    }
    
    var vipBannerList: [LBFMFocusImagesData]? {
        didSet {
            guard let model = vipBannerList else { return }
            self.vipBanner = model
            self.pagerView.reloadData()
        }
    }
}

extension LBFMHomeVipBannerCell: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return vipBannerList?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell:FSPagerViewCell = pagerView.dequeueReusableCell(withReuseIdentifier: "LBFMHomeVipBannerCell", at: index)
        cell.imageView?.kf.setImage(with: URL(string: (vipBanner?[index].cover)!))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let url:String = self.vipBanner?[index].link ?? ""
        delegate?.homeVipBannerCellClick(url: url)
    }
    
}

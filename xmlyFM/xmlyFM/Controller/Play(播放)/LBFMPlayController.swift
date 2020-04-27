//
//  LBFMPlayController.swift
//  xmlyFM
//
//  Created by Soul on 22/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMPlayController: UIViewController {

    // 外部传值请求接口
    private var albumId :Int = 0
    private var trackUid:Int = 0
    private var uid:Int = 0
    convenience init(albumId: Int = 0, trackUid: Int = 0, uid:Int = 0) {
        self.init()
        self.albumId = albumId
        self.trackUid = trackUid
        self.uid = uid
    }
    private let LBFMPlayHeaderViewID      = "LBFMPlayHeaderView"
    private let LBFMPlayFooterViewID      = "LBFMPlayFooterView"
    
    private let LBFMPlayCellID            = "LBFMPlayCell"
    private let LBFMPlayCommentCellID     = "LBFMPlayCommentCell"
    private let LBFMPlayAnchorCellID      = "LBFMPlayAnchorCell"
    private let LBFMPlayCircleCellID      = "LBFMPlayCircleCell"
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        // - 注册头视图和尾视图
        collection.register(LBFMPlayHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LBFMPlayHeaderViewID)
        collection.register(LBFMPlayFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LBFMPlayFooterViewID)
        // - 注册不同分区cell
        collection.register(LBFMPlayCell3.self, forCellWithReuseIdentifier: LBFMPlayCellID)
        collection.register(LBFMPlayCommentCell.self, forCellWithReuseIdentifier: LBFMPlayCommentCellID)
        collection.register(LBFMPlayAnchorCell.self, forCellWithReuseIdentifier: LBFMPlayAnchorCellID)
        collection.register(LBFMPlayCircleCell.self, forCellWithReuseIdentifier: LBFMPlayCircleCellID)
        
        return collection
    }()
    
    //模型数据
    lazy var viewModel: LBFMPlayViewModel = {
        return LBFMPlayViewModel(albumId:self.albumId,trackUid:self.trackUid, uid:self.uid)
    }()
    
    // - 导航栏左边按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "playpage_icon_down_black_30x30_"), for: .normal)
        button.addTarget(self, action: #selector(leftBarButtonClick), for: .touchUpInside)
        return button
    }()
    
    // - 导航栏右边按钮
    private lazy var rightBarButton1:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "playpage_icon_more_black_30x30_"), for: .normal)
        button.addTarget(self, action: #selector(rightBarButtonClick1), for: .touchUpInside)
        return button
    }()

    // - 导航栏右边按钮
    private lazy var rightBarButton2:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "playpage_icon_share_black_30x30_"), for: .normal)
        button.addTarget(self, action: #selector(rightBarButtonClick2), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        // 设置导航栏颜色
        navBarBarTintColor = UIColor.white
//        navBarBackgroundAlpha = 0
        view.addSubview(collectionView)   
        collectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: rightBarButton1), UIBarButtonItem(customView: rightBarButton2)]
        loadData()
    }
    
    func loadData(){
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            // 更新列表数据
            self.collectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }
    
    // 控制向上滚动显示导航栏标题和左右按钮
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY > 0 {
            navBarBackgroundAlpha = 1
        } else {
            navBarBackgroundAlpha = 0
        }
        
    }
}

// MARK: - 导航栏点击事件
extension LBFMPlayController {
    // - 导航栏左边消息点击事件
    @objc func leftBarButtonClick() {
        dismiss(animated: true, completion: nil)
    }
    
    // - 导航栏右边消息点击事件
    @objc func rightBarButtonClick1() {
        
    }
    
    // - 导航栏右边消息点击事件
    @objc func rightBarButtonClick2() {
        
    }
}

extension LBFMPlayController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return viewModel.numberOfSections(collectionView:collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell:LBFMPlayCell3 = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMPlayCellID, for: indexPath) as! LBFMPlayCell3
            cell.playTrackInfo = viewModel.playTrackInfo
            return cell
        } else if indexPath.section == 1 {
            let cell:LBFMPlayAnchorCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMPlayAnchorCellID, for: indexPath) as! LBFMPlayAnchorCell
            cell.userInfo = viewModel.userInfo
            return cell
        }else if indexPath.section == 2 {
            let cell:LBFMPlayCircleCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMPlayCircleCellID, for: indexPath) as! LBFMPlayCircleCell
            cell.communityInfo = viewModel.communityInfo
            return cell
        }else {
            let cell:LBFMPlayCommentCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMPlayCommentCellID, for: indexPath) as! LBFMPlayCommentCell
            cell.playCommentInfo = viewModel.playCommentInfo?[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let vc = YYNavigationController.init(rootViewController: FMPlayDetailController())
        //        self.navigationController?.pushViewController(vc, animated: true)
        //        self.dismiss(animated: true, completion: nil)
    }
    
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSectionAt(section: section)
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSectionAt(section: section)
    }
    
    // item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForFooterInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView:LBFMPlayHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LBFMPlayHeaderViewID, for: indexPath) as! LBFMPlayHeaderView
            return headerView
        } else if kind == UICollectionView.elementKindSectionFooter {
            let footerView:LBFMPlayFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LBFMPlayFooterViewID, for: indexPath) as! LBFMPlayFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
}

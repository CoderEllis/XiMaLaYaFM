//
//  LBFMRecommendNewsCell.swift
//  xmlyFM
//
//  Created by Soul on 22/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
///听头条
class LBFMRecommendNewsCell: UICollectionViewCell {
    private var LBFMNewsCellID = "LBFMNewsCell"
    private var topBuzz: [LBFMTopBuzzModel]?
    var time : Timer?
    
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "news.png")
        return imageView
    }()
    
    private lazy var moreBtn: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setTitle("|  更多", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: ScreenWidth - 150, height: 40)
        let collectionView = UICollectionView(frame: CGRect(x: 80, y: 5, width: ScreenWidth - 150, height: 40), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collectionView.contentSize = CGSize(width: ScreenWidth - 150, height: 40)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.register(LBFMNewsCell.self, forCellWithReuseIdentifier: LBFMNewsCellID)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        // 开启定时器
        starTimer() 
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func setupLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.top.equalTo(10)
        }
        
        addSubview(moreBtn)
        moreBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.width.equalTo(60)
            make.height.equalTo(40)
            make.top.equalTo(5)
        }
        addSubview(collectionView)
    }
    
    
    
    var topBuzzList : [LBFMTopBuzzModel]? {
        didSet {
            guard let model = topBuzzList else {
                return
            }
            topBuzz = model
            collectionView.reloadData()
        }
    }
    
}

extension LBFMRecommendNewsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.topBuzz?.count ?? 0)*100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:LBFMNewsCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMNewsCellID, for: indexPath) as! LBFMNewsCell
        cell.titleLabel.text = topBuzzList?[indexPath.row%(topBuzz?.count)!].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row%((topBuzz?.count)!))
    }
    
    
    func starTimer() {
        let time = Timer(timeInterval: 2, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
        // 这一句代码涉及到runloop 和 主线程的知识,则在界面上不能执行其他的UI操作
        RunLoop.main.add(time, forMode: .common)
        self.time = time
    }
    
    /// 在1秒后,自动跳转到下一页
    @objc func nextPage() {
        // 1.获取collectionView的X轴滚动的偏移量
        let currentOffsetY = collectionView.contentOffset.y
        
        let offSetY = currentOffsetY + collectionView.bounds.height
        // 2.滚动该位置
        collectionView.setContentOffset(CGPoint(x: 0, y: offSetY), animated: true)
    }
    
    /// 当collectionView开始拖动的时候,取消定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        time?.invalidate()
        time = nil
    }
    
    /// 当用户停止拖动的时候,开启定时器
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        starTimer()
    }
    
}

class LBFMNewsCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "123456"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

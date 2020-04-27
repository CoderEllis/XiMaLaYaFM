//
//  LBFMOneKeyListenCell.swift
//  xmlyFM
//
//  Created by Soul on 22/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMOneKeyListenCell: UICollectionViewCell {
    private var oneKeyListen:[LBFMOneKeyListenModel]?
    private lazy var changeBtn:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("换一批", for: .normal)
        button.setTitleColor(LBFMButtonColor, for: .normal)
        button.backgroundColor = UIColor.init(red: 254/255.0, green: 232/255.0, blue: 227/255.0, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(updataBtnClick(button:)), for: .touchUpInside)
        return button
    }()
    // - 懒加载九宫格分类按钮
    private lazy var gridView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: (ScreenWidth - 45) / 3, height:120)
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(LBOneKeyListenCell.self, forCellWithReuseIdentifier: "LBOneKeyListenCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    // 布局
    func setUpLayout(){
        addSubview(gridView)
        gridView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        addSubview(changeBtn)
        changeBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
    }
    // 更换一批按钮刷新cell
    @objc func updataBtnClick(button:UIButton){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var oneKeyListenList:[LBFMOneKeyListenModel]? {
        didSet {
            guard let model = oneKeyListenList else { return }
            oneKeyListen = model
            gridView.reloadData()
        }
    }
}

extension LBFMOneKeyListenCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return oneKeyListen?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:LBOneKeyListenCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LBOneKeyListenCell", for: indexPath) as! LBOneKeyListenCell
        cell.oneKeyListen = oneKeyListen?[indexPath.row]
        return cell
    }
}

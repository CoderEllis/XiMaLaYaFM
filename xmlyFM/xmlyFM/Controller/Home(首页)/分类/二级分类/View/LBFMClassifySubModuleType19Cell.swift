//
//  LBFMClassifySubModuleType19Cell.swift
//  xmlyFM
//
//  Created by Soul on 31/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class LBFMClassifySubModuleType19Cell: UICollectionViewCell {
    private var classifyModuleType19List:[LBFMClassifyModuleType19List]?
    // 细线
    private var lineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(r: 240, g: 240, b: 240)
        return view
    }()
    // 查看全部
    private lazy var moreBtn:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("查看全部 >", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.textAlignment = NSTextAlignment.center
        return button
    }()
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(150)
        }
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.width.right.equalToSuperview()
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview().offset(-40)
        }
        addSubview(moreBtn)
        moreBtn.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(5)
            make.width.equalTo(150)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
    }
    
    var classifyVerticalModel: LBFMClassifyVerticalModel? {
        didSet {
            guard let model = classifyVerticalModel else {return}
            classifyModuleType19List = model.list
            tableView.reloadData()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension LBFMClassifySubModuleType19Cell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.imageView?.image = UIImage(named: "play")
        cell.textLabel?.text = classifyModuleType19List?[indexPath.row].title
        return cell
    }
    
}

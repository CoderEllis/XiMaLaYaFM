

//
//  LBFMFindAttentionViewModel.swift
//  xmlyFM
//
//  Created by Soul on 21/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class LBFMFindAttentionViewModel: NSObject {
    var eventInfos : [LBFMEventInfosModel]?
    // - 数据源更新
    typealias LBFMAddDataBlock = () -> Void
    var updataBlock : LBFMAddDataBlock?
    
}

// MARK: - 请求数据
extension LBFMFindAttentionViewModel {
    func refreshDataSource() {
        // 1. 获取json文件路径
        let path = Bundle.main.path(forResource: "FindAttention", ofType: "json")
        // 2. 获取json文件里面的内容,NSData格式
        let jsonData = NSData(contentsOfFile: path!)
        // 3. 解析json内容
        let json = JSON(jsonData!)
        if let mappedObject = JSONDeserializer<LBFMEventInfosModel>.deserializeModelArrayFrom(json: json["data"]["eventInfos"].description) {
            self.eventInfos = mappedObject as? [LBFMEventInfosModel]
            self.updataBlock?()
        }
    }
}

extension LBFMFindAttentionViewModel {
    // 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return eventInfos?.count ?? 0
    }
    
    // 高度
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        let picNum = eventInfos?[indexPath.row].contentInfo?.picInfos?.count ?? 0
        var num:CGFloat = 0
        if picNum > 0 && picNum <= 3 {
            num = 1
        }else if picNum > 3 && picNum <= 6{
            num = 2
        }else if picNum > 6{
            num = 3
        }
        
        let OnePicHeight = CGFloat((ScreenWidth - 30) / 3)
        let picHeight = num * OnePicHeight
        let textHeight:CGFloat = height(for: eventInfos?[indexPath.row].contentInfo)
        
        return 60+50+picHeight+textHeight
    }
    
    private func height(for commentModel: LBFMFindAContentInfo?) -> CGFloat {
        var height: CGFloat = 44
        guard let model = commentModel else {
            return height
        }
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.text = model.text
        height += label.sizeThatFits(CGSize(width: ScreenWidth - 30, height: CGFloat.infinity)).height + 10
        return height
    }
}

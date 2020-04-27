//
//  File.swift
//  xmlyFM
//
//  Created by Soul on 19/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher
import SnapKit
import SwiftyJSON
import HandyJSON
import SwiftMessages

let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height

let LBFMButtonColor = UIColor(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let LBFMDownColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)


// iphone X
let isIphoneX = ScreenHeight == 812 ? true : false
// LBFMNavBarHeight
let LBFMNavBarHeight : CGFloat = isIphoneX ? 88 : 64
// LBFMTabBarHeight
let LBFMTabBarHeight : CGFloat = isIphoneX ? 49 + 34 : 49

// 自定义 Log
func printLog(_ message: Any, file: String = #file, line: Int = #line, function: String = #function)
{
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(function): \(message)\n")
    #endif
}

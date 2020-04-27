//
//  LBFMWebViewController.swift
//  xmlyFM
//
//  Created by Soul on 23/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import WebKit

class LBFMWebViewController: UIViewController {

    private var url:String = ""
    
    convenience init(url: String = "") {
        self.init()
        self.url = url
    }
    private lazy var webView:WKWebView = {
        let webView = WKWebView(frame: self.view.bounds)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(webView)
        webView.load(URLRequest.init(url: URL.init(string: self.url)!))
    }

}

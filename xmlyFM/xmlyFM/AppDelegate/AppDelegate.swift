//
//  AppDelegate.swift
//  xmlyFM
//
//  Created by Soul on 18/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import SwiftMessages
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 1.加载tabbar样式
        let tabbar = self.setupTabBarStyle(delegate: self as? UITabBarControllerDelegate)
        window?.backgroundColor = UIColor.white 
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
        
//        // 注册后台播放
//        let session = AVAudioSession.sharedInstance()
//        do {
//            //设置会话类型
//            if #available(iOS 10.0, *) {
//                try session.setCategory(.playback, mode: .default, options: .defaultToSpeaker)
//            } else {
//                // Fallback on earlier versions
//            }
//            //激活会话
//            try session.setActive(true)
//        } catch {
//            print(error)
//        }
        
        return true
    }
    
    /// 1.加载tabbar样式
    ///
    /// - Parameter delegate: 代理
    /// - Returns: ESTabBarController
    func setupTabBarStyle(delegate: UITabBarControllerDelegate?) -> ESTabBarController {
        let tabBarController = ESTabBarController()
        tabBarController.delegate = delegate
        tabBarController.title = "Irregularity"
        tabBarController.tabBar.shadowImage = UIImage(named: "transparent")
        tabBarController.shouldHijackHandler = {
            tabBarController, ViewController, index in
            if index == 2 {
                return true
            }
            return false
        }
        tabBarController.didHijackHandler = {
            [weak tabBarController] tabbarController, ViewController, index in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { 
                let warning = MessageView.viewFromNib(layout: .cardView)
                warning.configureTheme(.warning)
                warning.configureDropShadow()
                
                let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
                warning.configureContent(title: "Warning", body: "暂时没有此功能", iconText: iconText)
                warning.button?.isHidden = true
                var warningConfig = SwiftMessages.defaultConfig
                warningConfig.presentationContext = .window(windowLevel: .statusBar)
                SwiftMessages.show(config: warningConfig, view: warning)
                
            })
        }
        
        let home = LBFMHomeController()
        let listen = LBFMListenController()
        let play = LBFMPlayController()
        let find = LBFMFindController()
        let mine = LBFMMineController()
        
        home.tabBarItem = ESTabBarItem.init(LBFMIrregularityBasicContentView(), title: "首页", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        listen.tabBarItem = ESTabBarItem.init(LBFMIrregularityBasicContentView(), title: "我听", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
        play.tabBarItem = ESTabBarItem.init(LBFMIrregularityContentView(), title: "首页", image: UIImage(named: "tab_play"), selectedImage: UIImage(named: "tab_play"))
        find.tabBarItem = ESTabBarItem.init(LBFMIrregularityBasicContentView(), title: "发现", image: UIImage(named: "find"), selectedImage: UIImage(named: "find"))
        mine.tabBarItem = ESTabBarItem.init(LBFMIrregularityBasicContentView(), title: "我的", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        let homeNav = LBFMNavigationController.init(rootViewController: home)
        let listenNav = LBFMNavigationController.init(rootViewController: listen)
        let playNav = LBFMNavigationController.init(rootViewController: play)
        let findNav = LBFMNavigationController.init(rootViewController: find)
        let mineNav = LBFMNavigationController.init(rootViewController: mine)
        home.title = "首页"
        listen.title = "我听"
        play.title = "播放"
        find.title = "发现"
        mine.title = "我的"
        
        tabBarController.viewControllers = [homeNav, listenNav, playNav, findNav, mineNav]
        return tabBarController
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


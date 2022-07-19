//
//  AppDelegate.swift
//  GLMetaMask
//
//  Created by Gavin on 2022/6/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 15, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
            //此处针对UITableViewStyleGrouped tableview，tableHeaderView 会自带默认高度，导致tableview顶部会有空白问题
            let frame = CGRect.init(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude)
            UITableView.appearance().tableHeaderView = UIView.init(frame: frame)
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


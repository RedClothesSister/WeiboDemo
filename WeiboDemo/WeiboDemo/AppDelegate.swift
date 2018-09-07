//
//  AppDelegate.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/26.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit
import UserNotifications
import SVProgressHUD
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window?.backgroundColor = UIColor.white
        window?.rootViewController = WBMainViewController()
        window?.makeKeyAndVisible()
        
        setupAddition()
        
        return true
    }
}


//  MARK: - 从服务器加载应用数据

extension AppDelegate {
    private func loadAppInfo() {
        
        // 1.模拟异步
        DispatchQueue.global().async {
            
            let url = Bundle.main.path(forResource: "main.json", ofType: nil)
            let data = NSData(contentsOfFile: url!)
            
            // 写入磁盘
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
            // 直接保存在沙盒中，等待下次程序使用
            data?.write(toFile: jsonPath, atomically: true)
        }
    }
}


// MARK: - 设置额外信息

extension AppDelegate {
    
    
    private func setupAddition() {
        
        // 设置SVProgressHUD显示的最小时间
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        
        // 设置网络加载指示器
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        
        // 取得用户申请授权显示通知
        if #available(iOS 10, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .badge, .sound, .carPlay]) { (granted, error) in
                
            }
        } else {
            let notifySetting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notifySetting)
        }
    }
}

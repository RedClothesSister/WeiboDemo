//
//  WBMainViewController.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/26.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit
import SVProgressHUD

private let fileName = "main.json"

class WBMainViewController: UITabBarController {
    
    private lazy var composeButton = UIButton()
    
    private lazy var orientations = UIInterfaceOrientationMask.portrait
    
    // 定时器
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildController()
        setupComposeButton()
        delegate = self
        
        setupTimer()

        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin), name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
        
        // 设置新特性视图
        setupNewFeatureView()
    }
    
    deinit {
        // 销毁定时器
        timer?.invalidate()
        
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func userLogin(n: Notification) {
        
        let vc = WBOAuthViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
        
    }
    
    // 设置屏幕的方向
    /*
     * portrait -> 竖屏，肖像
     * landscape -> 横屏，风景
     * 使用代码控制设备的方向，好处：可以在需要横屏的时候单独处理。
     * 设置支持的方向之后，当前的控制器及子控制器都会遵守这个方向
     * 如果需要横屏，可以通过Model展现
    */
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return orientations
        }
        set {
            orientations = newValue
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc private func composeButtonClick() {
        
        // 测试旋转方向
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.magenta
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true, completion: nil)
    }
}

extension WBMainViewController {
    
    // 设置TabBar中间按钮
    private func setupComposeButton() {
        // 设置按钮的图片和背景颜色
        composeButton.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add"), for: .normal)
        composeButton.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button"), for: .normal)
        
        tabBar.addSubview(composeButton)
        
        // 设置按钮的位置
        // 计算item的个数
        let count = CGFloat(childViewControllers.count)
        // 计算每一个宽度的个数
        let tabBarWidth = tabBar.bounds.width / count
        
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * tabBarWidth, dy: 0)
        
        // 设置按钮监听方法
        composeButton.addTarget(self, action: #selector(composeButtonClick), for: .touchUpInside)
    }
    
    // 设置所有的子控制器
    private func setupChildController() {
        
        // 获取沙盒json路径
        let jsonPath = WBGetFilePath.getFilePath(fileName: fileName)
        // 加载data
        var data = NSData(contentsOfFile: jsonPath)
        
        // 判断data是否有值，如果没有，说明本地沙盒没有文件
        if data == nil {
            let path = Bundle.main.path(forResource: fileName, ofType: nil)
            data = NSData(contentsOfFile: path!)
        }
        
        // data一定会有值
        
        // 从Bundle中加载配置json
        // 反序列化转换成数组
        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String: Any]] else {
            return
        }
        var arrayModel = [UIViewController]()
        for dict in array! {
            arrayModel.append(controller(dict: dict as [String : AnyObject]))
        }
        
        viewControllers = arrayModel
    }
    
    private func controller(dict: [String: AnyObject]) -> UIViewController {
        
        // 1.取得字典内容
        guard let clsName = dict["clsName"] as? String,
              let title = dict["title"] as? String,
              let imageName = dict["imageName"] as? String,
              let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? WBBaseViewController.Type,
              let visitorDict = dict["visitorInfo"] as? [String: String] else {
                return UIViewController()
        }
        
        // 2.创建视图控制器
        let vc = cls.init()
        vc.title = title
        vc.visitorInfoDictionary = visitorDict
        
        // 3.设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        // 4.设置tabbar标题字体
        tabBar.tintColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        
        let nav = WBNavigationController(rootViewController: vc)
        return nav
    }
}


// MARK: - 时钟相关方法

extension WBMainViewController {
    
    //
    private func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        
        if !WBNetworkManager.shared.userLogon {
            return
        }
        
        WBNetworkManager.shared.unreadCount { (count) in
            
            print("检测到\(count)条新微博")
            // 设置首页 tabbarItem 的badgeNumber
            if count > 0 {
                self.tabBar.items?[0].badgeValue = "\(count)"
            } else {
                self.tabBar.items?[0].badgeValue = nil
            }
            
            // 设置App 的badgeValue   从iOS 8.0之后，要要用户授权才能够显示
            UIApplication.shared.applicationIconBadgeNumber = count
        }
    }
}


// MARK: - UITabBarControllerDelegate

extension WBMainViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        // 获取控制器在数组中的索引
        let index = (childViewControllers as NSArray).index(of: viewController)
        
        // 判断当前索引是首页， 同时index也是首页 相当于重复点击首页
        if selectedIndex == 0 && index == selectedIndex {
            print("点击了首页")
            
            // 让表格滚动到顶部
            // 获取到控制器
            let nav = childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! WBHomeViewController
            
            // 滚动至首页
            vc.baseTabeView?.setContentOffset(CGPoint(x: 0, y: -64), animated: true)
            
            // 刷新数据 -- 增加延迟，是保证表格先滚动到顶部再刷新数据
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                vc.loadData()
            }
            
            // 清除tabbar的badgeNumber
            vc.tabBarItem.badgeValue = nil
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        
        // 判断目标是否是 UIViewController
        return !viewController.isMember(of: UIViewController.self)
    }
}


// MARK: - 设置新特性视图

extension WBMainViewController {
    private func setupNewFeatureView() {
        
        // 0. 判断是否登录
        if !WBNetworkManager.shared.userLogon {
            return
        }
        
        // 1.检查版本是否更新
        
        // 2.如果更新，显示新特性，否则显示欢迎页面
        let v = isNewVersion ? WBWelcomeView() : WBNewFeatureView()
        
        // 3.添加视图
        v.frame = UIScreen.main.bounds
        view.addSubview(v)
    }
    
    // extension 中可以有计算型属性，不会占用存储空间
    // 版本信息
    /*
     * 在App Store每次升级应用程序，都需要增加
     * 主版本号.次版本号.修订版本号
     * 主版本号：意味着大量的修改，使用者也需要大的适应
     * 次版本号：意味着小的修改，某些函数和方法的使用或者参数有变化
     * 修订版本号：框架或者程序内部bug的修订，不会对使用者造成任何的影响
     */
    private var isNewVersion: Bool {
        
        // 1.取当前的版本号
        let dict = Bundle.main.infoDictionary
        //print(dict)
        let currentVersion = dict?["CFBundleShortVersionString"] as? String ?? ""
        //print(currentVersion)
        
        // 2.取保存在 Document 目录中的之前的版本号
        let fileName = "version"
        
        let jsonPath = WBGetFilePath.getFilePath(fileName: fileName)
        //print(jsonPath)
        
        guard let data = NSData(contentsOfFile: jsonPath),
            let sandBoxVersionDict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String: AnyObject] else {
                return false
        }
        
        let sandBoxVersion = sandBoxVersionDict!["version"] as? String ?? ""
        //print(sandBoxVersion)
        
        // 3.将之前的版本号存储
        let versionDict = ["version": "\(currentVersion)"]
        WBGetFilePath.writeFileToDisk(dict: versionDict as [String: AnyObject], fileName: fileName)
        
        // 4.判断两和版本是否相同
        if currentVersion != sandBoxVersion {
            return true
        } else {
            return false
        }
    }
}

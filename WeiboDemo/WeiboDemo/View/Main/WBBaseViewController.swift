//
//  WBBaseViewController.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/26.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {
    
    // 自定义导航条
    lazy var navigationBar = WBCustomNavigationBar()
    
    // 定义navigationTitle
    lazy var navigationItemTitle = UINavigationItem()
    
    // 创建表格视图,如果用户没有登录不创建表格
    var baseTabeView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64)
        
        setupUI()
        loadData()
    }
    
    func loadData() {
        
    }
    
    // 重写title的 setter方法
    override var title: String? {
        didSet {
            navigationItemTitle.title = title
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
/*
 * 1.extension中不能有属性
 * 2.extension中不能重写父类的方法
 */


// MARK: - Extension Methods

extension WBBaseViewController {
    
    // 设置界面
    @objc func setupUI() {
        
        UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        
        setupNavigation()
        setupTableView()
    }
    
    // 设置导航条
    private func setupNavigation() {
        // 添加导航条
        view.addSubview(navigationBar)
        
        
        // 将item设置给Bar
        navigationBar.items = [navigationItemTitle]
        
        // 设置navigationBar的渲染颜色
        navigationBar.barTintColor = UIColor.barTintColor
        
        // 设置navigationBar的字体颜色
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.darkGray, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 19)]
    }
    
    // 设置tableView
    private func setupTableView() {
        baseTabeView = UITableView(frame: view.bounds, style: .plain)
        
        baseTabeView?.delegate = self
        baseTabeView?.dataSource = self
        
        // 设置内容缩进
        baseTabeView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height, left: 0, bottom: tabBarController?.tabBar.bounds.height ?? 0, right: 0)
        
        view.insertSubview(baseTabeView!, belowSubview: navigationBar)
    }
}


// MARK: - UITableVeiwDelegate,UITableViewDataSource Methods

extension WBBaseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // 基类只是准备方法，子类负责具体的实现。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 只是保证没有语法错误
        return UITableViewCell()
    }
    
    
}

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
    
    //定义刷新控件
    var refreshControl: UIRefreshControl?
    
    // 上拉刷新的标记
    var isPullUp = false
    
    // 用户登录标记
    var userLogon = false
    
    //
    var visitorInfoDictionary: [String: String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64)
        
        setupUI()
        loadData()
    }
    
    @objc func loadData() {
        
        // 如果子类不实现任何方法，默认关闭刷新控件
        refreshControl?.endRefreshing()
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
        view.backgroundColor = UIColor.white
        
        UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        
        setupNavigation()
        
        if userLogon {
            setupTableView()
        } else {
            setupVisitorView()
        }
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
        
        // 1.设置刷新控件
        refreshControl = UIRefreshControl()
        // 2.添加到表格视图
        baseTabeView?.addSubview(refreshControl!)
        // 3.添加监听方法
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    // 设置访问视图
    private func setupVisitorView() {
        let visitorView = WBVisitorView(frame: view.bounds)
        view.insertSubview(visitorView, belowSubview: navigationBar)
        
        visitorView.visitorInfo = visitorInfoDictionary
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
    
    // 最后一行的时候 上拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // 1.判断indexPath是否是最后一行
        // 先取出row
        let row = indexPath.row
        // 取出section的个数
        let section = (baseTabeView?.numberOfSections)! - 1
        
        if row < 0 || section < 0 {
            return
        }
        
        let count = tableView.numberOfRows(inSection: section)
        
        // 如果是最后一行同时没有开始上拉刷新
        if row == count - 1 && !isPullUp {
            isPullUp = true
            
            // 开始刷新
            loadData()
        }
    }
    
}

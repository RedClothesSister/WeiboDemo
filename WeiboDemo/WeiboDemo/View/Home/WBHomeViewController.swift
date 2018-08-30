//
//  WBHomeViewController.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/26.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class WBHomeViewController: WBBaseViewController {
    
    private lazy var listViewModel = WBStatusesListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func loadData() {
        
        listViewModel.loadStatuses(pullup: self.isPullUp) { (isSuccess, shouldRefresh) in
            // 结束刷新
            self.refreshControl?.endRefreshing()
            
            self.isPullUp = false
            
            if shouldRefresh {
                self.baseTabeView?.reloadData()
            }
        }
    }
    
    @objc private func showFriends() {
        
        let vc = WBDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - 表格数据源方法

extension WBHomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = listViewModel.statusesList[indexPath.row].text
        return cell
    }
}


// MARK: -

extension WBHomeViewController {
    
    override func setupTableView() {
        
        super.setupTableView()
        navigationItemTitle.leftBarButtonItem = UIBarButtonItem(title: "好友", textColor: UIColor.themeColor, target: self, action: #selector(showFriends))
        
        // 注册原型cell
        baseTabeView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}

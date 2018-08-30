//
//  WBStatusesListViewModel.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/30.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import Foundation

// 微博数据列表视图模型
// 父类的选择
/*
 * 如果类需要使用 KVC 或者子弹转模型框架设置，类就需要继承子 NSObject
 * 如果类只是包装代码逻辑(写了一些函数)，可以不用继承父类，好处：更加轻量级
 * 作用： 负责微博数据处理
 * 1. 字典转模型
 * 2.下拉上拉刷新
 */
class WBStatusesListViewModel {
    
    lazy var statusesList = [WBStatuses]()
    
    func loadStatuses(completion: @escaping (_ isSuccess: Bool) -> ()) {
        
        // since_id 下拉刷新，取出数组中的第一条微博的id
        let since_id = statusesList.first?.id ?? 0
        
        WBNetworkManager.shared.statuses(since_id: since_id, max_id: 0) { (list, isSuccess) in
            
            // 1. 字典转模型
            guard let array = NSArray.yy_modelArray(with: WBStatuses.self, json: list ?? []) as? [WBStatuses] else {
                completion(isSuccess)
                return
            }
            // 2.拼接数据
            // 下拉刷新应该将数据插入在前面
            self.statusesList = array + self.statusesList
            
            // 3.完成回调
            completion(isSuccess)
        }
    }
}

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
private var maxPullupTimes = 3

class WBStatusesListViewModel {
    
    lazy var statusesList = [WBStatuses]()
    private var pullupErrorTimes = 0
    
    func loadStatuses(pullup: Bool, completion: @escaping (_ isSuccess: Bool, _ shouldRefresh: Bool) -> ()) {
        
        if pullup && pullupErrorTimes > maxPullupTimes {
            completion(true, false)
            
            return
        }
        
        // since_id 取出数组中第一条微博的ID
        let since_id = pullup ? 0 : (self.statusesList.first?.id ?? 0)
        // max_ix 取出数组中的最后一条微博的ID
        let max_id = !pullup ? 0 : (self.statusesList.last?.id ?? 0)
        
        WBNetworkManager.shared.statuses(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            
            // 1. 字典转模型
            guard let array = NSArray.yy_modelArray(with: WBStatuses.self, json: list ?? []) as? [WBStatuses] else {
                completion(isSuccess, false)
                return
            }
            if pullup {
                // 上拉刷新，将结果拼接在数组中的最前面
                self.statusesList += array
            } else {
                // 下拉刷新，将结果拼接在数组中的最后面
                self.statusesList = array + self.statusesList
            }
            
            if pullup && array.count == 0 {
                self.pullupErrorTimes += 1
                completion(isSuccess,false)
                
            } else {
                // 3.完成回调
                completion(isSuccess, true)
            }
            
        }
    }
}

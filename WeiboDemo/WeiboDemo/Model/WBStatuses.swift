//
//  WBStatuses.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/30.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit
import YYModel

// 微博数据模型
// 模型的每一个属性加上@objc --> 解决YYModel数组转模型的后数组为nil的Bug
class WBStatuses: NSObject {
    // 微博ID
    @objc var id: Int64 = 0
    // 微博信息内容
    @objc var text: String?
    
    // 重写description 的计算型属性
    override var description: String {
        return yy_modelDescription()
    }
}

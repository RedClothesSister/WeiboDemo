//
//  WBNetworkManager.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/29.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit
import AFNetworking

// 网络管理工具
class WBNetworkManager: AFHTTPSessionManager {
    
    // 创建单例
    static let shared = WBNetworkManager()
    
}

//
//  WBNetworkManager.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/29.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import UIKit
import AFNetworking

// 枚举支持任何的数据类型
enum WBHTTPMathod {
    case GET
    case POST
}

// 网络管理工具
class WBNetworkManager: AFHTTPSessionManager {
    
    // 创建单例
    static let shared = WBNetworkManager()
    
    
    // 使用一个函数封装AFN的get和post请求
    func request(method: WBHTTPMathod = .GET, URLString: String, parameters: [String: AnyObject], completion: @escaping (_ json: Any?, _ isSuccess: Bool) -> ()) {
        
        // 成功回调
        let success = { (task: URLSessionDataTask, json: Any?) -> () in
            completion(json, true)
        }
        
        // 失败回调
        let failure = { (task: URLSessionDataTask?, error: NSError) -> () in
            
            // error通常比较复杂
            print("网络请求错误", error)
            completion(nil, false)
        }
        
        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure as? (URLSessionDataTask?, Error) -> Void)
        } else {
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure as? (URLSessionDataTask?, Error) -> Void)
        }
    }
}

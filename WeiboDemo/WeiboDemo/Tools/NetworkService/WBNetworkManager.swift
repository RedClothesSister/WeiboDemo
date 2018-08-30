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
    
    // 访问令牌, 所有的网络请求都基于此令牌(登录除外)
    var accessToken: String? = "2.00heeKrFSw4QDB874ca1a2abuDmXuB"
    
    // 专门负责拼接token的网络请求方法
    func tokenRequest(method: WBHTTPMathod = .GET, URLString: String, parameters: [String: AnyObject]?, completion: @escaping (_ json: Any?, _ isSuccess: Bool) -> ()) {
        
        // 0.处理token字典
        guard let token = accessToken else {
            print("没有token！需要登录")
            completion(nil, false)
            
            return
        }
        // 1.判断参数字典是否存在，如果为nil，应该新建一个字典
        var parameters = parameters
        if parameters == nil {
            // 实例化一个字典
            parameters = [String: AnyObject]()
        }
        
        // 2.设置参数字典
        parameters!["access_token"] = token as AnyObject
        
        // 调用request 发起真正的网络请求
        request(URLString: URLString, parameters: parameters, completion: completion)
    }
    
    // 使用一个函数封装AFN的get和post请求
    func request(method: WBHTTPMathod = .GET, URLString: String, parameters: [String: AnyObject]?, completion: @escaping (_ json: Any?, _ isSuccess: Bool) -> ()) {
        
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

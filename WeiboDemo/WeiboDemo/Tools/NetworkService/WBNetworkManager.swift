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
enum WBHTTPMethod {
    case GET
    case POST
}

// 网络管理工具
class WBNetworkManager: AFHTTPSessionManager {
    
    // 创建单例
    static let shared = WBNetworkManager()
    
    
    lazy var userAccount = WBUesrAccount()
    
    var userLogon: Bool {
        return userAccount.access_token != nil
    }
    
    // 专门负责拼接token的网络请求方法
    func tokenRequest(method: WBHTTPMethod = .GET, URLString: String, parameters: [String: AnyObject]?, completion: @escaping (_ json: Any?, _ isSuccess: Bool) -> ()) {
        
        // 0.处理token字典
        guard let token = userAccount.access_token else {
            
            // 没有token
            // 发送通知，提示用户登录   一般应用程序在运行过程中，token不会为nil
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
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
    func request(method: WBHTTPMethod = .GET, URLString: String, parameters: [String: AnyObject]?, completion: @escaping (_ json: Any?, _ isSuccess: Bool) -> ()) {
        // 成功回调
        let success = { (task: URLSessionDataTask, json: Any?) -> () in
            completion(json, true)
        }
        
        // 失败回调
        let failure = { (task: URLSessionDataTask?, error: NSError) -> () in
            
            // 针对403处理用户token过期
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("Token过期了")
                
                // 发送通知(本方法不知道被谁调用，谁接收到通知，谁处理)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: "bad token")
            }
            
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

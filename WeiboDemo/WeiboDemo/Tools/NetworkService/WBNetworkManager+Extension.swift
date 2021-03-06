//
//  WBNetworkManager+Extension.swift
//  WeiboDemo
//
//  Created by 黄君伟 on 2018/8/29.
//  Copyright © 2018年 黄君伟. All rights reserved.
//

import Foundation

extension WBNetworkManager {
    
    // since_id: 返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
    // max_id: 返回ID小于或等于max_id的微博，默认为0。
    
    func statuses(since_id: Int64 = 0, max_id: Int64 = 0, completion: @escaping (_ list: [[String: AnyObject]]?, _ isSuccess: Bool) -> ()) {
        
        
        // 用AFN网络工具加载微博数据
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        let params = ["since_id": "\(since_id)", "max_id": "\(max_id > 0 ? max_id - 1 : 0)"]
        
        // 网络请求
        tokenRequest(method: .GET, URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            
            // 从json中获取字典数组  如果 as？失败，result为nil
            guard let json = json else {
                return
            }
            let result = (json as! NSDictionary)["statuses"] as? [[String: AnyObject]]
            completion(result, isSuccess)
        }
    }
    
    // 微博未读数量
    func unreadCount(completion: @escaping (_ count: Int) -> ()) {
        guard let uid = userAccount.uid else {
            return
        }
        
        let urlString = "https://rm.api.weibo.com/2/remind/unread_count.json"
        let params = ["uid": uid]
        
        tokenRequest(URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            let dict = json as? [String: AnyObject]
            let count = dict?["status"] as? Int
            
            completion(count ?? 0)
        }
    }
}


// MARK: - OAuth相关方法

extension WBNetworkManager {
    
    // 获取token
    func getAccessToken(code: String?, completion: @escaping (_ isSuccess: Bool) -> ()) {
        
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        let params = ["client_id": WBAppKey, "client_secret": WBAppScrect, "grant_type": "authorization_code", "code": code, "redirect_uri": WBRedirectURI]
        
        // 发送网络请求
        request(method: .POST, URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            
            // 如果请求失败，对用户账户数据不会有任何的影响
            guard let json = json else {
                return
            }
            self.userAccount.yy_modelSet(with: json as? [String: AnyObject] ?? [:])
            
            // 加载用户信息
            self.loadUserInfo(completion: { (dict) in
                print(dict)
                
                self.userAccount.yy_modelSet(with: dict)
                self.userAccount.saveAccountToDisk()
                print(self.userAccount)
                
                // 用户信息加载完成再完成回调
                completion(isSuccess)
            })
        }
    }
}


// MARK: - 加载用户信息

extension WBNetworkManager {
    
    func loadUserInfo(completion: @escaping (_ dict: [String: AnyObject]) -> ()) {
        
        guard let uid = userAccount.uid else {
            return
        }
        
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        let params = ["uid": uid]
        
        // 发起网络请求
        tokenRequest(URLString: urlString, parameters: params as [String: AnyObject]) { (json, isSuccess) in
            
            completion(json as? [String: AnyObject] ?? [:])
        }
    }
}

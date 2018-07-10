//
//  DCCJUserManager.swift
//  TTVV
//
//  Created by 龚欢 on 2018/7/3.
//  Copyright © 2018年 龚欢. All rights reserved.
//

import Foundation

public class DCCJUser {
    
    private let TOKEN_KEY: String = "TOKEN_KEY"
    
    public init() {}
    
    public func setToken(_ t: String, callback: ((Bool) -> Void)?) {
        if (!t.isEmpty) {
            UserDefaults.standard.set(t, forKey: self.TOKEN_KEY)
            UserDefaults.standard.synchronize()
            if let c = callback { c(true) }
        } else if t.isEmpty {
            UserDefaults.standard.removeObject(forKey: self.TOKEN_KEY)
            UserDefaults.standard.synchronize()
            if let c = callback { c(true) }
        } else {
            if let c = callback { c(false) }
        }
    }
    
    public func getToken() -> String {
        if let t = UserDefaults.standard.object(forKey: self.TOKEN_KEY) as? String {
            return t
        }
        return ""
    }
}

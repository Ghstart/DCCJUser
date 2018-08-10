//
//  DCCJUserManager.swift
//  TTVV
//
//  Created by 龚欢 on 2018/7/3.
//  Copyright © 2018年 龚欢. All rights reserved.
//

import Foundation
import DCCJConfig

public class DCCJUser {
    
    private let TOKEN_KEY: String       = "TOKEN_KEY"
    private let USERINFO_KEY: String    = "USERINFO_KEY"
    
    public var userInfo: UserSecondData?
    public typealias Handler = (Result<UserInfoResponse>) -> Void
    
    public enum UserInfoTypes {
        case allUserInfo
        case onlyToken
    }
    
    public enum UserInfoError: Error {
        case authorized(e: Error)
    }
    
    public init() {}
    
    public var token: String  {
        set {
            if !newValue.isEmpty {
                UserDefaults.standard.set(newValue, forKey: self.TOKEN_KEY)
                UserDefaults.standard.synchronize()
            } else {
                UserDefaults.standard.removeObject(forKey: self.TOKEN_KEY)
                UserDefaults.standard.synchronize()
            }
        }
        get {
            return UserDefaults.standard.object(forKey: self.TOKEN_KEY) as? String ?? ""
        }
    }
    
    public func authorize(by userInfoData: Data, then handler: @escaping Handler) {
        do {
            let userInfoResponse = try JSONDecoder().decode(UserInfoResponse.self, from: userInfoData)
            handler(.success(userInfoResponse))
            if let u = userInfoResponse.data {
                self.userInfo = u
                UserDefaults.standard.set(u, forKey: self.USERINFO_KEY)
                UserDefaults.standard.synchronize()
            }
        } catch let e {
            handler(.failure(e))
        }
    }
    
    public func clear(by: UserInfoTypes = .allUserInfo) {
        switch by {
        case .allUserInfo:
            UserDefaults.standard.removeObject(forKey: self.USERINFO_KEY)
            UserDefaults.standard.synchronize()
        case .onlyToken:
            UserDefaults.standard.removeObject(forKey: self.TOKEN_KEY)
            UserDefaults.standard.synchronize()
        }
    }
}

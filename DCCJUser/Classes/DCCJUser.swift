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
    
    public enum DCCJUserError: Error {
        case unknowError
        case decodeeError(err: Error)
        
        public var errorMessage: String {
            switch self {
            case .unknowError:
                return "未知异常"
            case .decodeeError(let err):
                return err.localizedDescription
            }
        }
    }
    
    public lazy var info: UserSecondData? = {
        if let decoded = UserDefaults.standard.object(forKey: self.USERINFO_KEY) as? Data,
            let decodedUserInfo = try? PropertyListDecoder().decode(UserSecondData.self, from: decoded) {
            return decodedUserInfo
        }
        return nil
    }()
    
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
            if let u = userInfoResponse.data {
                if let t = u.accessToken { self.token = t }
                let defaults = UserDefaults.standard
                defaults.set(try? PropertyListEncoder().encode(u), forKey: self.USERINFO_KEY)
                defaults.synchronize()
                
                handler(.success(userInfoResponse))
            } else {
                handler(.failure(DCCJUserError.unknowError))
            }
        } catch let e {
            handler(.failure(DCCJUserError.decodeeError(err: e)))
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
    
    public var isIdentity: Bool {
        if let r = self.info?.userInfo?.realName, !r.isEmpty, let idCard = self.info?.userInfo?.idCard, !idCard.isEmpty {
            
            return true
            
        } else if let v = self.info?.userInfo?.isVerified, v == 1 {
            
            return true
        }
        
        return false
    }
    
    public var displayName: String {
        if let name = self.info?.userInfo?.realName, !name.isEmpty {
            var stringDatas = [String]()
            for i in 0..<name.count {
                if i == 0 {
                    stringDatas.append(String(name[..<name.index(name.startIndex, offsetBy: 1)]))
                } else {
                    stringDatas.append("*")
                }
            }
            return stringDatas.joined()
        }
        return ""
    }
}


//
//  UserInfo.swift
//  DCCJUser
//
//  Created by 龚欢 on 2018/7/20.
//

import Foundation

public struct UserInfoResponse: Codable {
    public let success: Bool
    public let resultMessage: String?
    public let resultCode: String
    public let data: UserSecondData?
}

public struct UserSecondData: Codable {
    public let userInfo: UserInfoData?
    public let accessToken: String?
}

public struct UserInfoData: Codable {
    
//    enum UserGenderType: Int, Codable {
//        case UserGenderTypeUnknown = 0
//        case UserGenderTypeMale
//        case UserGenderTypeFemale
//    }
    
    public let balance: String?
    public let carCount: Int
    public let defaultBankCard: String?
    public let gender: Int
    public let headPhotoUrl: String?
    public let hycBalance: String?
    public let idCard: String?
    public let isLoginPasswordSet: Int
    public let isPayPasswordSet: Int
    public let isVerified: Int
    public let loginCount: Int
    public let loginPswSetToken: String?
    public let memberId: String
    public let nickName: String?
    public let phoneNumber: String
    public let realName: String?
}


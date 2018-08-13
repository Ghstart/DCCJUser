//
//  UserInfo.swift
//  DCCJUser
//
//  Created by 龚欢 on 2018/7/20.
//

import Foundation

public struct UserInfoResponse: Codable {
    let success: Bool
    let resultMessage: String?
    let resultCode: String
    let data: UserSecondData?
    init(success: Bool, resultMessage: String?, resultCode: String, data: UserSecondData?) {
        self.success = success
        self.resultMessage = resultMessage
        self.resultCode = resultCode
        self.data = data
    }
}

public struct UserSecondData: Codable {
    let userInfo: UserInfoData?
    let accessToken: String?
}

public struct UserInfoData: Codable {
    
    enum UserGenderType: Int, Codable {
        case UserGenderTypeUnknown = 0
        case UserGenderTypeMale
        case UserGenderTypeFemale
    }
    
    let balance: String?
    let carCount: Int
    let defaultBankCard: String?
    let gender: UserGenderType
    let headPhotoUrl: String?
    let hycBalance: String?
    let idCard: String?
    let isLoginPasswordSet: Int
    let isPayPasswordSet: Int
    let isVerified: Int
    let loginCount: Int
    let loginPswSetToken: String?
    let memberId: String
    let nickName: String?
    let phoneNumber: String
    let realName: String?
}


//
//  LoginModels.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 04/08/21.
//

import Foundation



struct TokenModel : Codable {
    let token : String?
    let validTo : String?

    enum CodingKeys: String, CodingKey {

        case token = "Token"
        case validTo = "ValidTo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        validTo = try values.decodeIfPresent(String.self, forKey: .validTo)
    }

}

struct LoginModels : Codable {
    let userID : String?
    let appName : String?
    let appSecret : String?
    let clientID : String?
    let fullName : String?
    let email : String?
    let adminYN : String?
    let isPWChanged : Bool?
    let planType : String?

    enum CodingKeys: String, CodingKey {

        case userID = "UserID"
        case appName = "AppName"
        case appSecret = "AppSecret"
        case clientID = "ClientID"
        case fullName = "FullName"
        case email = "Email"
        case adminYN = "AdminYN"
        case isPWChanged = "IsPWChanged"
        case planType = "PlanType"
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        userID = try values.decodeIfPresent(String.self, forKey: .userID)
//        appName = try values.decodeIfPresent(String.self, forKey: .appName)
//        appSecret = try values.decodeIfPresent(String.self, forKey: .appSecret)
//        clientID = try values.decodeIfPresent(String.self, forKey: .clientID)
//        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
//        email = try values.decodeIfPresent(String.self, forKey: .email)
//        adminYN = try values.decodeIfPresent(String.self, forKey: .adminYN)
//        isPWChanged = try values.decodeIfPresent(Bool.self, forKey: .isPWChanged)
//        planType = try values.decodeIfPresent(String.self, forKey: .planType)
//    }

}

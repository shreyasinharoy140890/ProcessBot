//
//  UserManagementModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 07/09/21.
//


import Foundation
struct UserListModel : Codable {
    let iD : String?
    let username : String?
    let email : String?
    let fullName : String?
    let lastSuccessfulLogin : String?
    let roleID : Int?
    let roleName : String?
    let createdBy : String?
    let createDate : String?
    let activeYN : String?
    let adminYN : String?

    enum CodingKeys: String, CodingKey {

        case iD = "ID"
        case username = "Username"
        case email = "Email"
        case fullName = "FullName"
        case lastSuccessfulLogin = "LastSuccessfulLogin"
        case roleID = "RoleID"
        case roleName = "RoleName"
        case createdBy = "CreatedBy"
        case createDate = "CreateDate"
        case activeYN = "ActiveYN"
        case adminYN = "AdminYN"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iD = try values.decodeIfPresent(String.self, forKey: .iD)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        lastSuccessfulLogin = try values.decodeIfPresent(String.self, forKey: .lastSuccessfulLogin)
        roleID = try values.decodeIfPresent(Int.self, forKey: .roleID)
        roleName = try values.decodeIfPresent(String.self, forKey: .roleName)
        createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
        createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
        activeYN = try values.decodeIfPresent(String.self, forKey: .activeYN)
        adminYN = try values.decodeIfPresent(String.self, forKey: .adminYN)
    }

}
struct RoleListModel : Codable {
    let roleID : Int?
    let roleName : String?
    let roleDescription : String?
    let isActive : Bool?
    let createDate : String?
    let createdBy : String?
    let userCount : Int?

    enum CodingKeys: String, CodingKey {

        case roleID = "RoleID"
        case roleName = "RoleName"
        case roleDescription = "RoleDescription"
        case isActive = "IsActive"
        case createDate = "CreateDate"
        case createdBy = "CreatedBy"
        case userCount = "UserCount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        roleID = try values.decodeIfPresent(Int.self, forKey: .roleID)
        roleName = try values.decodeIfPresent(String.self, forKey: .roleName)
        roleDescription = try values.decodeIfPresent(String.self, forKey: .roleDescription)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
        createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
        userCount = try values.decodeIfPresent(Int.self, forKey: .userCount)
    }

}

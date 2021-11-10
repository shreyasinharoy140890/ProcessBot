//
//  RoleUpdate.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 18/10/21.
//

import Foundation

struct RoleUpdate: Codable{
    let RoleID: String
    let ClientID: String
    let RoleName: String
    let RoleDescription: String
    let Permission: [RolePermissionList]
}


struct RolePermissionList: Codable{
    let ComponentID: Int
    let ComponentCode: String
    let ComponentName: String
    let IsView: Bool
    let IsAdd: Bool
    let IsEdit: Bool
    let IsDelete: Bool
    
    
    
}

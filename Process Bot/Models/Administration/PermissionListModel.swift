//
//  PermissionListModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 10/09/21.
//

import Foundation
struct PermissionListModel : Codable {
    let componentID : Int?
    let componentCode : String?
    let componentName : String?
    var isView : Bool?
    var isAdd : Bool?
    var isEdit : Bool?
    var isDelete : Bool?

    enum CodingKeys: String, CodingKey {

        case componentID = "ComponentID"
        case componentCode = "ComponentCode"
        case componentName = "ComponentName"
        case isView = "IsView"
        case isAdd = "IsAdd"
        case isEdit = "IsEdit"
        case isDelete = "IsDelete"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        componentID = try values.decodeIfPresent(Int.self, forKey: .componentID)
        componentCode = try values.decodeIfPresent(String.self, forKey: .componentCode)
        componentName = try values.decodeIfPresent(String.self, forKey: .componentName)
        isView = try values.decodeIfPresent(Bool.self, forKey: .isView)
        isAdd = try values.decodeIfPresent(Bool.self, forKey: .isAdd)
        isEdit = try values.decodeIfPresent(Bool.self, forKey: .isEdit)
        isDelete = try values.decodeIfPresent(Bool.self, forKey: .isDelete)
    }

}

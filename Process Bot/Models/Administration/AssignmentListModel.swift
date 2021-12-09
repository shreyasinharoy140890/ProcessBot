//
//  RobotListmodel.swift
//  Process Bot
//
//  Created by Appsbee on 08/12/21.
//

import Foundation
struct AssignmentListModel : Codable {
    let publishedScriptID : String?
    let robotName : String?
    let version : String?
    let assignedBy : String?
    let assignedID : Int?
    let assignedToUserID : String?
    let assignedByUserID : String?
    var enabled : Bool?

    enum CodingKeys: String, CodingKey {

        case publishedScriptID = "PublishedScriptID"
        case robotName = "RobotName"
        case version = "Version"
        case assignedBy = "AssignedBy"
        case assignedID = "AssignedID"
        case assignedToUserID = "AssignedToUserID"
        case assignedByUserID = "AssignedByUserID"
        case enabled = "Enabled"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        publishedScriptID = try values.decodeIfPresent(String.self, forKey: .publishedScriptID)
        robotName = try values.decodeIfPresent(String.self, forKey: .robotName)
        version = try values.decodeIfPresent(String.self, forKey: .version)
        assignedBy = try values.decodeIfPresent(String.self, forKey: .assignedBy)
        assignedID = try values.decodeIfPresent(Int.self, forKey: .assignedID)
        assignedToUserID = try values.decodeIfPresent(String.self, forKey: .assignedToUserID)
        assignedByUserID = try values.decodeIfPresent(String.self, forKey: .assignedByUserID)
        enabled = try values.decodeIfPresent(Bool.self, forKey: .enabled)
    }

}

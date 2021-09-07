//
//  TopTenRobotModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 13/08/21.
//

import Foundation
struct topTenRobotDataModel : Codable {
    let robotName : String?
    let sucessRate : Int?

    enum CodingKeys: String, CodingKey {

        case robotName = "RobotName"
        case sucessRate = "SucessRate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        robotName = try values.decodeIfPresent(String.self, forKey: .robotName)
        sucessRate = try values.decodeIfPresent(Int.self, forKey: .sucessRate)
    }

}

//
//  TopTenNonPerformer.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 16/08/21.
//

import Foundation
struct TopTenNonPerformerDataModel : Codable {
    let robotName : String?
    let errorCount : Int?
    let errorRate : Int?

    enum CodingKeys: String, CodingKey {

        case robotName = "RobotName"
        case errorCount = "ErrorCount"
        case errorRate = "ErrorRate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        robotName = try values.decodeIfPresent(String.self, forKey: .robotName)
        errorCount = try values.decodeIfPresent(Int.self, forKey: .errorCount)
        errorRate = try values.decodeIfPresent(Int.self, forKey: .errorRate)
    }

}

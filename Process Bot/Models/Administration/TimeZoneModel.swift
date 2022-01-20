//
//  TimeZoneModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 22/09/21.
//

import Foundation
struct TimeZoneModel : Codable {
    let iD : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case iD = "ID"
        case name = "Name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iD = try values.decodeIfPresent(String.self, forKey: .iD)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}

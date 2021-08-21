//
//  SuccessRateDataModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 20/08/21.
//

import Foundation
struct SuccessRateDataModel : Codable {
    let sucessRate : Int?
    let errorRate : Int?

    enum CodingKeys: String, CodingKey {

        case sucessRate = "SucessRate"
        case errorRate = "ErrorRate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sucessRate = try values.decodeIfPresent(Int.self, forKey: .sucessRate)
        errorRate = try values.decodeIfPresent(Int.self, forKey: .errorRate)
    }

}

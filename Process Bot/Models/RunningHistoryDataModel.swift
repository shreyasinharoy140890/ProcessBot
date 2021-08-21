//
//  RunningHistoryDataModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 20/08/21.
//

import Foundation
struct RunningHistoryDataModel : Codable {
    let dateTime : String?
    let running : Int?
    let completed : Int?
    let error : Int?
    let cancelled : Int?

    enum CodingKeys: String, CodingKey {

        case dateTime = "DateTime"
        case running = "Running"
        case completed = "Completed"
        case error = "Error"
        case cancelled = "Cancelled"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        running = try values.decodeIfPresent(Int.self, forKey: .running)
        completed = try values.decodeIfPresent(Int.self, forKey: .completed)
        error = try values.decodeIfPresent(Int.self, forKey: .error)
        cancelled = try values.decodeIfPresent(Int.self, forKey: .cancelled)
    }

}

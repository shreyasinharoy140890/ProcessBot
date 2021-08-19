//
//  ActivityDataModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 19/08/21.
//

import Foundation
struct ActivityDataModel : Codable {
    let date : String?
    let totalRun : Int?
    let running : Int?
    let completed : Int?
    let error : Int?
    let paused : Int?
    let cancelled : Int?

    enum CodingKeys: String, CodingKey {

        case date = "Date"
        case totalRun = "TotalRun"
        case running = "Running"
        case completed = "Completed"
        case error = "Error"
        case paused = "Paused"
        case cancelled = "Cancelled"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        totalRun = try values.decodeIfPresent(Int.self, forKey: .totalRun)
        running = try values.decodeIfPresent(Int.self, forKey: .running)
        completed = try values.decodeIfPresent(Int.self, forKey: .completed)
        error = try values.decodeIfPresent(Int.self, forKey: .error)
        paused = try values.decodeIfPresent(Int.self, forKey: .paused)
        cancelled = try values.decodeIfPresent(Int.self, forKey: .cancelled)
    }

}

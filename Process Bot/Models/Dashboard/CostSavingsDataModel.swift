//
//  CostSavingsDataModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 16/08/21.
//

import Foundation
struct CostsavingsDataModel : Codable {
    let maxDate : String?
    let runFor : String?
    let directoryName : String?
    let existingCost : Double?
    let rPACost : Double?
    let costSavings : Double?
    let noOfFTEs : Int?
    let fTENeeded : Int?
    let fTESavings : Int?
    let timeSavingsMinute : Int?

    enum CodingKeys: String, CodingKey {

        case maxDate = "MaxDate"
        case runFor = "RunFor"
        case directoryName = "DirectoryName"
        case existingCost = "ExistingCost"
        case rPACost = "RPACost"
        case costSavings = "CostSavings"
        case noOfFTEs = "NoOfFTEs"
        case fTENeeded = "FTENeeded"
        case fTESavings = "FTESavings"
        case timeSavingsMinute = "TimeSavingsMinute"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        maxDate = try values.decodeIfPresent(String.self, forKey: .maxDate)
        runFor = try values.decodeIfPresent(String.self, forKey: .runFor)
        directoryName = try values.decodeIfPresent(String.self, forKey: .directoryName)
        existingCost = try values.decodeIfPresent(Double.self, forKey: .existingCost)
        rPACost = try values.decodeIfPresent(Double.self, forKey: .rPACost)
        costSavings = try values.decodeIfPresent(Double.self, forKey: .costSavings)
        noOfFTEs = try values.decodeIfPresent(Int.self, forKey: .noOfFTEs)
        fTENeeded = try values.decodeIfPresent(Int.self, forKey: .fTENeeded)
        fTESavings = try values.decodeIfPresent(Int.self, forKey: .fTESavings)
        timeSavingsMinute = try values.decodeIfPresent(Int.self, forKey: .timeSavingsMinute)
    }

}

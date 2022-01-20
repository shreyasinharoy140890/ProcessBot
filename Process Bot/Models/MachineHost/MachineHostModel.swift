//
//  MachineHostModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 24/08/21.
//

import Foundation
struct MachineHostModel : Codable {
    let workerID : String?
    let machineName : String?
    let userName : String?
    let lastCheckIn : String?
    let status : Int?
    let clientID : String?
    let machineKey : String?
    let oSType : String?
    let oSVersion : String?
    let createdBy : String?
    let createDate : String?
    let connectedYN : String?
    let conRemarks : String?
    let renewYN : String?

    enum CodingKeys: String, CodingKey {

        case workerID = "WorkerID"
        case machineName = "MachineName"
        case userName = "UserName"
        case lastCheckIn = "LastCheckIn"
        case status = "Status"
        case clientID = "ClientID"
        case machineKey = "MachineKey"
        case oSType = "OSType"
        case oSVersion = "OSVersion"
        case createdBy = "CreatedBy"
        case createDate = "CreateDate"
        case connectedYN = "ConnectedYN"
        case conRemarks = "ConRemarks"
        case renewYN = "RenewYN"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        workerID = try values.decodeIfPresent(String.self, forKey: .workerID)
        machineName = try values.decodeIfPresent(String.self, forKey: .machineName)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        lastCheckIn = try values.decodeIfPresent(String.self, forKey: .lastCheckIn)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        clientID = try values.decodeIfPresent(String.self, forKey: .clientID)
        machineKey = try values.decodeIfPresent(String.self, forKey: .machineKey)
        oSType = try values.decodeIfPresent(String.self, forKey: .oSType)
        oSVersion = try values.decodeIfPresent(String.self, forKey: .oSVersion)
        createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
        createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
        connectedYN = try values.decodeIfPresent(String.self, forKey: .connectedYN)
        conRemarks = try values.decodeIfPresent(String.self, forKey: .conRemarks)
        renewYN = try values.decodeIfPresent(String.self, forKey: .renewYN)
    }

}

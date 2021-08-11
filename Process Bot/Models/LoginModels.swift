//
//  LoginModels.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 04/08/21.
//

import Foundation



struct TokenModel : Codable {
    let token : String?
    let validTo : String?

    enum CodingKeys: String, CodingKey {

        case token = "Token"
        case validTo = "ValidTo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        validTo = try values.decodeIfPresent(String.self, forKey: .validTo)
    }

}

struct LoginModels : Codable {
    let userID : String?
    let appName : String?
    let appSecret : String?
    let clientID : String?
    let fullName : String?
    let email : String?
    let adminYN : String?
    let isPWChanged : Bool?
    let planType : String?

    enum CodingKeys: String, CodingKey {

        case userID = "UserID"
        case appName = "AppName"
        case appSecret = "AppSecret"
        case clientID = "ClientID"
        case fullName = "FullName"
        case email = "Email"
        case adminYN = "AdminYN"
        case isPWChanged = "IsPWChanged"
        case planType = "PlanType"
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        userID = try values.decodeIfPresent(String.self, forKey: .userID)
//        appName = try values.decodeIfPresent(String.self, forKey: .appName)
//        appSecret = try values.decodeIfPresent(String.self, forKey: .appSecret)
//        clientID = try values.decodeIfPresent(String.self, forKey: .clientID)
//        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
//        email = try values.decodeIfPresent(String.self, forKey: .email)
//        adminYN = try values.decodeIfPresent(String.self, forKey: .adminYN)
//        isPWChanged = try values.decodeIfPresent(Bool.self, forKey: .isPWChanged)
//        planType = try values.decodeIfPresent(String.self, forKey: .planType)
//    }

}

struct PublishedRobotModel : Codable {
    let publishedScriptID : String?
    let workerID : String?
    let publishedOn : String?
    let scriptType : Int?
    let friendlyName : String?
    let scriptData : String?
    let description : String?
    let workerName : String?
    let machineName : String?
    let overwriteExisting : Bool?
    let clientID : String?
    let directoryID : Int?
    let machineKey : String?
    let version : String?
    let mejorVersion : Int?
    let minorVersion : Int?
    let robotType : String?
    let totMinute : Int?
    let avgMinute : Int?
    let timeSaved : Int?
    let runCount : Int?
    let totalTimeSaved : Int?
    let lastRunTime : String?
    let lastRunStatus : String?
    let currentYN : String?
    let currentStaus : String?
    let rOIPlanID : Int?
    let processName : String?
    let logoPath : String?

    enum CodingKeys: String, CodingKey {

        case publishedScriptID = "PublishedScriptID"
        case workerID = "WorkerID"
        case publishedOn = "PublishedOn"
        case scriptType = "ScriptType"
        case friendlyName = "FriendlyName"
        case scriptData = "ScriptData"
        case description = "Description"
        case workerName = "WorkerName"
        case machineName = "MachineName"
        case overwriteExisting = "OverwriteExisting"
        case clientID = "ClientID"
        case directoryID = "DirectoryID"
        case machineKey = "MachineKey"
        case version = "Version"
        case mejorVersion = "MejorVersion"
        case minorVersion = "MinorVersion"
        case robotType = "RobotType"
        case totMinute = "TotMinute"
        case avgMinute = "AvgMinute"
        case timeSaved = "TimeSaved"
        case runCount = "RunCount"
        case totalTimeSaved = "TotalTimeSaved"
        case lastRunTime = "LastRunTime"
        case lastRunStatus = "LastRunStatus"
        case currentYN = "CurrentYN"
        case currentStaus = "CurrentStaus"
        case rOIPlanID = "ROIPlanID"
        case processName = "ProcessName"
        case logoPath = "LogoPath"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        publishedScriptID = try values.decodeIfPresent(String.self, forKey: .publishedScriptID)
        workerID = try values.decodeIfPresent(String.self, forKey: .workerID)
        publishedOn = try values.decodeIfPresent(String.self, forKey: .publishedOn)
        scriptType = try values.decodeIfPresent(Int.self, forKey: .scriptType)
        friendlyName = try values.decodeIfPresent(String.self, forKey: .friendlyName)
        scriptData = try values.decodeIfPresent(String.self, forKey: .scriptData)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        workerName = try values.decodeIfPresent(String.self, forKey: .workerName)
        machineName = try values.decodeIfPresent(String.self, forKey: .machineName)
        overwriteExisting = try values.decodeIfPresent(Bool.self, forKey: .overwriteExisting)
        clientID = try values.decodeIfPresent(String.self, forKey: .clientID)
        directoryID = try values.decodeIfPresent(Int.self, forKey: .directoryID)
        machineKey = try values.decodeIfPresent(String.self, forKey: .machineKey)
        version = try values.decodeIfPresent(String.self, forKey: .version)
        mejorVersion = try values.decodeIfPresent(Int.self, forKey: .mejorVersion)
        minorVersion = try values.decodeIfPresent(Int.self, forKey: .minorVersion)
        robotType = try values.decodeIfPresent(String.self, forKey: .robotType)
        totMinute = try values.decodeIfPresent(Int.self, forKey: .totMinute)
        avgMinute = try values.decodeIfPresent(Int.self, forKey: .avgMinute)
        timeSaved = try values.decodeIfPresent(Int.self, forKey: .timeSaved)
        runCount = try values.decodeIfPresent(Int.self, forKey: .runCount)
        totalTimeSaved = try values.decodeIfPresent(Int.self, forKey: .totalTimeSaved)
        lastRunTime = try values.decodeIfPresent(String.self, forKey: .lastRunTime)
        lastRunStatus = try values.decodeIfPresent(String.self, forKey: .lastRunStatus)
        currentYN = try values.decodeIfPresent(String.self, forKey: .currentYN)
        currentStaus = try values.decodeIfPresent(String.self, forKey: .currentStaus)
        rOIPlanID = try values.decodeIfPresent(Int.self, forKey: .rOIPlanID)
        processName = try values.decodeIfPresent(String.self, forKey: .processName)
        logoPath = try values.decodeIfPresent(String.self, forKey: .logoPath)
    }

}

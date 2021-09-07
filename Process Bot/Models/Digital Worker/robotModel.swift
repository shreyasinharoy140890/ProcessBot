//
//  robotModel.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 06/08/21.
//

import Foundation

struct ScheduleModel : Codable {
    let scheduledID : Int?
    let workerID : String?
    let workerType : String?
    let machineName : String?
    let userName : String?
    let iPAddress : String?
    let executionType : String?
    let publishedScriptID : String?
    let status : String?
    let remark : String?
    let scheduledType : String?
    let scheduledPeriod : Int?
    let weekDayName : String?
    let scheduledDatetime : String?
    let lastRunTime : String?
    let nextRunTime : String?
    let friendlyName : String?
    let clientID : String?
    let userID : String?
    let activeYN : String?
    let timeZone : String?
    let machineKey : String?
    let oSType : String?
    let scheduledBy : String?

    enum CodingKeys: String, CodingKey {

        case scheduledID = "ScheduledID"
        case workerID = "WorkerID"
        case workerType = "WorkerType"
        case machineName = "MachineName"
        case userName = "UserName"
        case iPAddress = "IPAddress"
        case executionType = "ExecutionType"
        case publishedScriptID = "PublishedScriptID"
        case status = "Status"
        case remark = "Remark"
        case scheduledType = "ScheduledType"
        case scheduledPeriod = "ScheduledPeriod"
        case weekDayName = "WeekDayName"
        case scheduledDatetime = "ScheduledDatetime"
        case lastRunTime = "LastRunTime"
        case nextRunTime = "NextRunTime"
        case friendlyName = "FriendlyName"
        case clientID = "ClientID"
        case userID = "UserID"
        case activeYN = "ActiveYN"
        case timeZone = "TimeZone"
        case machineKey = "MachineKey"
        case oSType = "OSType"
        case scheduledBy = "ScheduledBy"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        scheduledID = try values.decodeIfPresent(Int.self, forKey: .scheduledID)
        workerID = try values.decodeIfPresent(String.self, forKey: .workerID)
        workerType = try values.decodeIfPresent(String.self, forKey: .workerType)
        machineName = try values.decodeIfPresent(String.self, forKey: .machineName)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        iPAddress = try values.decodeIfPresent(String.self, forKey: .iPAddress)
        executionType = try values.decodeIfPresent(String.self, forKey: .executionType)
        publishedScriptID = try values.decodeIfPresent(String.self, forKey: .publishedScriptID)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        remark = try values.decodeIfPresent(String.self, forKey: .remark)
        scheduledType = try values.decodeIfPresent(String.self, forKey: .scheduledType)
        scheduledPeriod = try values.decodeIfPresent(Int.self, forKey: .scheduledPeriod)
        weekDayName = try values.decodeIfPresent(String.self, forKey: .weekDayName)
        scheduledDatetime = try values.decodeIfPresent(String.self, forKey: .scheduledDatetime)
        lastRunTime = try values.decodeIfPresent(String.self, forKey: .lastRunTime)
        nextRunTime = try values.decodeIfPresent(String.self, forKey: .nextRunTime)
        friendlyName = try values.decodeIfPresent(String.self, forKey: .friendlyName)
        clientID = try values.decodeIfPresent(String.self, forKey: .clientID)
        userID = try values.decodeIfPresent(String.self, forKey: .userID)
        activeYN = try values.decodeIfPresent(String.self, forKey: .activeYN)
        timeZone = try values.decodeIfPresent(String.self, forKey: .timeZone)
        machineKey = try values.decodeIfPresent(String.self, forKey: .machineKey)
        oSType = try values.decodeIfPresent(String.self, forKey: .oSType)
        scheduledBy = try values.decodeIfPresent(String.self, forKey: .scheduledBy)
    }

}

struct InActionModel : Codable {
    let friendlyName : String?
    let publishedOn : String?
    let publishedScriptID : String?
    let scriptType : Int?
    let workerID : String?
    let taskID : String?
    let machineName : String?
    let workerName : String?
    let machineKey : String?
    let robotType : String?
    let version : String?
    let avgMinute : Int?
    let lastRunTime : String?
    let currentStaus : String?
    let remarks : String?
    let runByName : String?
    let taskStarted : String?
    let taskLastPausedTime : String?
    let taskLastResumeTime : String?
    let progressTimeSecond : String?

    enum CodingKeys: String, CodingKey {

        case friendlyName = "FriendlyName"
        case publishedOn = "PublishedOn"
        case publishedScriptID = "PublishedScriptID"
        case scriptType = "ScriptType"
        case workerID = "WorkerID"
        case taskID = "TaskID"
        case machineName = "MachineName"
        case workerName = "WorkerName"
        case machineKey = "MachineKey"
        case robotType = "RobotType"
        case version = "Version"
        case avgMinute = "AvgMinute"
        case lastRunTime = "LastRunTime"
        case currentStaus = "CurrentStaus"
        case remarks = "Remarks"
        case runByName = "RunByName"
        case taskStarted = "TaskStarted"
        case taskLastPausedTime = "TaskLastPausedTime"
        case taskLastResumeTime = "TaskLastResumeTime"
        case progressTimeSecond = "ProgressTimeSecond"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        friendlyName = try values.decodeIfPresent(String.self, forKey: .friendlyName)
        publishedOn = try values.decodeIfPresent(String.self, forKey: .publishedOn)
        publishedScriptID = try values.decodeIfPresent(String.self, forKey: .publishedScriptID)
        scriptType = try values.decodeIfPresent(Int.self, forKey: .scriptType)
        workerID = try values.decodeIfPresent(String.self, forKey: .workerID)
        taskID = try values.decodeIfPresent(String.self, forKey: .taskID)
        machineName = try values.decodeIfPresent(String.self, forKey: .machineName)
        workerName = try values.decodeIfPresent(String.self, forKey: .workerName)
        machineKey = try values.decodeIfPresent(String.self, forKey: .machineKey)
        robotType = try values.decodeIfPresent(String.self, forKey: .robotType)
        version = try values.decodeIfPresent(String.self, forKey: .version)
        avgMinute = try values.decodeIfPresent(Int.self, forKey: .avgMinute)
        lastRunTime = try values.decodeIfPresent(String.self, forKey: .lastRunTime)
        currentStaus = try values.decodeIfPresent(String.self, forKey: .currentStaus)
        remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
        runByName = try values.decodeIfPresent(String.self, forKey: .runByName)
        taskStarted = try values.decodeIfPresent(String.self, forKey: .taskStarted)
        taskLastPausedTime = try values.decodeIfPresent(String.self, forKey: .taskLastPausedTime)
        taskLastResumeTime = try values.decodeIfPresent(String.self, forKey: .taskLastResumeTime)
        progressTimeSecond = try values.decodeIfPresent(String.self, forKey: .progressTimeSecond)
    }
    

}

struct logHistoryModel : Codable {
    let triggerID : String?
    let publishedScriptID : String?
    let hostName : String?
    let robotName : String?
    let eventStatus : String?
    let eventTime : String?
    let eventRaiseBy : String?

    enum CodingKeys: String, CodingKey {

        case triggerID = "TriggerID"
        case publishedScriptID = "PublishedScriptID"
        case hostName = "HostName"
        case robotName = "RobotName"
        case eventStatus = "EventStatus"
        case eventTime = "EventTime"
        case eventRaiseBy = "EventRaiseBy"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        triggerID = try values.decodeIfPresent(String.self, forKey: .triggerID)
        publishedScriptID = try values.decodeIfPresent(String.self, forKey: .publishedScriptID)
        hostName = try values.decodeIfPresent(String.self, forKey: .hostName)
        robotName = try values.decodeIfPresent(String.self, forKey: .robotName)
        eventStatus = try values.decodeIfPresent(String.self, forKey: .eventStatus)
        eventTime = try values.decodeIfPresent(String.self, forKey: .eventTime)
        eventRaiseBy = try values.decodeIfPresent(String.self, forKey: .eventRaiseBy)
    }

}


struct robitDetailsModel : Codable {
    let friendlyName : String?
    let publishedOn : String?
    let publishedScriptID : String?
    let scriptType : Int?
    let workerID : String?
    let taskID : String?
    let machineName : String?
    let workerName : String?
    let machineKey : String?
    let robotType : String?
    let version : String?
    let executionTime : String?
    let timeSaved : String?
    let lastRunTime : String?
    let startTime : String?
    let endTime : String?
    let currentStaus : String?
    let remarks : String?
    let runByName : String?

    enum CodingKeys: String, CodingKey {

        case friendlyName = "FriendlyName"
        case publishedOn = "PublishedOn"
        case publishedScriptID = "PublishedScriptID"
        case scriptType = "ScriptType"
        case workerID = "WorkerID"
        case taskID = "TaskID"
        case machineName = "MachineName"
        case workerName = "WorkerName"
        case machineKey = "MachineKey"
        case robotType = "RobotType"
        case version = "Version"
        case executionTime = "ExecutionTime"
        case timeSaved = "TimeSaved"
        case lastRunTime = "LastRunTime"
        case startTime = "StartTime"
        case endTime = "EndTime"
        case currentStaus = "CurrentStaus"
        case remarks = "Remarks"
        case runByName = "RunByName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        friendlyName = try values.decodeIfPresent(String.self, forKey: .friendlyName)
        publishedOn = try values.decodeIfPresent(String.self, forKey: .publishedOn)
        publishedScriptID = try values.decodeIfPresent(String.self, forKey: .publishedScriptID)
        scriptType = try values.decodeIfPresent(Int.self, forKey: .scriptType)
        workerID = try values.decodeIfPresent(String.self, forKey: .workerID)
        taskID = try values.decodeIfPresent(String.self, forKey: .taskID)
        machineName = try values.decodeIfPresent(String.self, forKey: .machineName)
        workerName = try values.decodeIfPresent(String.self, forKey: .workerName)
        machineKey = try values.decodeIfPresent(String.self, forKey: .machineKey)
        robotType = try values.decodeIfPresent(String.self, forKey: .robotType)
        version = try values.decodeIfPresent(String.self, forKey: .version)
        executionTime = try values.decodeIfPresent(String.self, forKey: .executionTime)
        timeSaved = try values.decodeIfPresent(String.self, forKey: .timeSaved)
        lastRunTime = try values.decodeIfPresent(String.self, forKey: .lastRunTime)
        startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
        endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
        currentStaus = try values.decodeIfPresent(String.self, forKey: .currentStaus)
        remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
        runByName = try values.decodeIfPresent(String.self, forKey: .runByName)
    }

}

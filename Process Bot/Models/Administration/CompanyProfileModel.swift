//
//  CompanyProfileModel.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 20/09/21.
//

import Foundation
struct LicenceListModel : Codable {
    let custID : Int?
    let licenseID : Int?
    let clientID : String?
    let licenseKey : String?
    let KeyType : String?
    let validity : Int?
    let hostNo : Int?
    let robotNo : Int?
    let userNo : Int?
    let attendentNo : Int?
    let unAttendentNo : Int?
    let activationDate : String?
    let installedWorkerNo : Int?
    let runningRobot : Int?
    let runningAttendent : String?
    let runningUnAttendent : String?
    let KeyActiveYN : String?
    let renewPeriodMonths : Int?
    let nextRenewDate : String?
    let renewYN : String?
    let planHostNo : Int?
    let planRobotNo : Int?
    let planUserNo : Int?
    let additionalHostNo : Int?
    let additionalRobotNo : Int?
    let additionalUserNo : Int?
    let additionalAttendedNo : Int?
    let additionalUnattendedNo : Int?
    let adiitionalStandAloneHostNo : Int?
    let additionalServerHostNo : Int?
    let isCurrent : Bool?

    enum CodingKeys: String, CodingKey {

        case custID = "CustID"
        case licenseID = "LicenseID"
        case clientID = "ClientID"
        case licenseKey = "LicenseKey"
        case KeyType = "KeyType"
        case validity = "Validity"
        case hostNo = "HostNo"
        case robotNo = "RobotNo"
        case userNo = "UserNo"
        case attendentNo = "AttendentNo"
        case unAttendentNo = "UnAttendentNo"
        case activationDate = "ActivationDate"
        case installedWorkerNo = "InstalledWorkerNo"
        case runningRobot = "RunningRobot"
        case runningAttendent = "RunningAttendent"
        case runningUnAttendent = "RunningUnAttendent"
        case KeyActiveYN = "KeyActiveYN"
        case renewPeriodMonths = "RenewPeriodMonths"
        case nextRenewDate = "NextRenewDate"
        case renewYN = "RenewYN"
        case planHostNo = "PlanHostNo"
        case planRobotNo = "PlanRobotNo"
        case planUserNo = "PlanUserNo"
        case additionalHostNo = "AdditionalHostNo"
        case additionalRobotNo = "AdditionalRobotNo"
        case additionalUserNo = "AdditionalUserNo"
        case additionalAttendedNo = "AdditionalAttendedNo"
        case additionalUnattendedNo = "AdditionalUnattendedNo"
        case adiitionalStandAloneHostNo = "AdiitionalStandAloneHostNo"
        case additionalServerHostNo = "AdditionalServerHostNo"
        case isCurrent = "IsCurrent"
    }

    
}
struct ProfileListModel : Codable {
    let custID : Int?
    let gatewayCustID : String?
    let applicantType : String?
    let custFirstName : String?
    let custLastName : String?
    let custFullName : String?
    let workEmail : String?
    let phoneNo : String?
    let department : String?
    let timeZoneID : String?
    let designation : String?
    let companyName : String?
    let companyCountry : String?
    let state : String?
    let industry : String?
    let message : String?
    let customerYN : String?
    let customerType : String?
    let clientID : String?
    let salesPerson : String?
    let salesPersionEmpID : Int?
    let planID : Int?
    let planAmount : Double?
    let additionalAttendedAmount : Double?
    let additionalUnattendedAmount : Double?
    let additionalServerHostAmount : Double?
    let additionalStandAloneHostAmount : Double?
    let totalAmount : Double?
    let installmentAmount : Double?
    let installmentPeriod : Int?
    let paidAmount : Double?
    let dueAmount : Double?
    let nextDueDate : String?
    let planName : String?
    let planDescription : String?

    enum CodingKeys: String, CodingKey {

        case custID = "CustID"
        case gatewayCustID = "GatewayCustID"
        case applicantType = "ApplicantType"
        case custFirstName = "CustFirstName"
        case custLastName = "CustLastName"
        case custFullName = "CustFullName"
        case workEmail = "WorkEmail"
        case phoneNo = "PhoneNo"
        case department = "Department"
        case timeZoneID = "TimeZoneID"
        case designation = "Designation"
        case companyName = "CompanyName"
        case companyCountry = "CompanyCountry"
        case state = "State"
        case industry = "Industry"
        case message = "Message"
        case customerYN = "CustomerYN"
        case customerType = "CustomerType"
        case clientID = "ClientID"
        case salesPerson = "SalesPerson"
        case salesPersionEmpID = "SalesPersionEmpID"
        case planID = "PlanID"
        case planAmount = "PlanAmount"
        case additionalAttendedAmount = "AdditionalAttendedAmount"
        case additionalUnattendedAmount = "AdditionalUnattendedAmount"
        case additionalServerHostAmount = "AdditionalServerHostAmount"
        case additionalStandAloneHostAmount = "AdditionalStandAloneHostAmount"
        case totalAmount = "TotalAmount"
        case installmentAmount = "InstallmentAmount"
        case installmentPeriod = "InstallmentPeriod"
        case paidAmount = "PaidAmount"
        case dueAmount = "DueAmount"
        case nextDueDate = "NextDueDate"
        case planName = "PlanName"
        case planDescription = "PlanDescription"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        custID = try values.decodeIfPresent(Int.self, forKey: .custID)
        gatewayCustID = try values.decodeIfPresent(String.self, forKey: .gatewayCustID)
        applicantType = try values.decodeIfPresent(String.self, forKey: .applicantType)
        custFirstName = try values.decodeIfPresent(String.self, forKey: .custFirstName)
        custLastName = try values.decodeIfPresent(String.self, forKey: .custLastName)
        custFullName = try values.decodeIfPresent(String.self, forKey: .custFullName)
        workEmail = try values.decodeIfPresent(String.self, forKey: .workEmail)
        phoneNo = try values.decodeIfPresent(String.self, forKey: .phoneNo)
        department = try values.decodeIfPresent(String.self, forKey: .department)
        timeZoneID = try values.decodeIfPresent(String.self, forKey: .timeZoneID)
        designation = try values.decodeIfPresent(String.self, forKey: .designation)
        companyName = try values.decodeIfPresent(String.self, forKey: .companyName)
        companyCountry = try values.decodeIfPresent(String.self, forKey: .companyCountry)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        industry = try values.decodeIfPresent(String.self, forKey: .industry)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        customerYN = try values.decodeIfPresent(String.self, forKey: .customerYN)
        customerType = try values.decodeIfPresent(String.self, forKey: .customerType)
        clientID = try values.decodeIfPresent(String.self, forKey: .clientID)
        salesPerson = try values.decodeIfPresent(String.self, forKey: .salesPerson)
        salesPersionEmpID = try values.decodeIfPresent(Int.self, forKey: .salesPersionEmpID)
        planID = try values.decodeIfPresent(Int.self, forKey: .planID)
        planAmount = try values.decodeIfPresent(Double.self, forKey: .planAmount)
        additionalAttendedAmount = try values.decodeIfPresent(Double.self, forKey: .additionalAttendedAmount)
        additionalUnattendedAmount = try values.decodeIfPresent(Double.self, forKey: .additionalUnattendedAmount)
        additionalServerHostAmount = try values.decodeIfPresent(Double.self, forKey: .additionalServerHostAmount)
        additionalStandAloneHostAmount = try values.decodeIfPresent(Double.self, forKey: .additionalStandAloneHostAmount)
        totalAmount = try values.decodeIfPresent(Double.self, forKey: .totalAmount)
        installmentAmount = try values.decodeIfPresent(Double.self, forKey: .installmentAmount)
        installmentPeriod = try values.decodeIfPresent(Int.self, forKey: .installmentPeriod)
        paidAmount = try values.decodeIfPresent(Double.self, forKey: .paidAmount)
        dueAmount = try values.decodeIfPresent(Double.self, forKey: .dueAmount)
        nextDueDate = try values.decodeIfPresent(String.self, forKey: .nextDueDate)
        planName = try values.decodeIfPresent(String.self, forKey: .planName)
        planDescription = try values.decodeIfPresent(String.self, forKey: .planDescription)
    }

}


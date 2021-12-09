//
//  AssignmentUpdate.swift
//  Process Bot
//
//  Created by Appsbee on 09/12/21.
//

import Foundation
struct AssignmentUpdate: Codable{
    let ClientID: String
    let AssignedByUserID: String
    let AssignedList: [AssignmentList]
}


struct AssignmentList: Codable{
    let AssignedID: Int
    let PublishedScriptID: String
    let AssignedToUserID: String
    let Enabled: Bool
   
}

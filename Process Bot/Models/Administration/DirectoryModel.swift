

import Foundation
struct DirectoryModel : Codable {
    let directoryID : Int?
    let clientID : String?
    let directoryName : String?
    let description : String?
    let isDelete : Bool?
    let ownerID : String?
    let createDate : String?
    let editedBy : String?
    let editDate : String?

    enum CodingKeys: String, CodingKey {

        case directoryID = "DirectoryID"
        case clientID = "ClientID"
        case directoryName = "DirectoryName"
        case description = "Description"
        case isDelete = "IsDelete"
        case ownerID = "OwnerID"
        case createDate = "CreateDate"
        case editedBy = "EditedBy"
        case editDate = "EditDate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        directoryID = try values.decodeIfPresent(Int.self, forKey: .directoryID)
        clientID = try values.decodeIfPresent(String.self, forKey: .clientID)
        directoryName = try values.decodeIfPresent(String.self, forKey: .directoryName)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        isDelete = try values.decodeIfPresent(Bool.self, forKey: .isDelete)
        ownerID = try values.decodeIfPresent(String.self, forKey: .ownerID)
        createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
        editedBy = try values.decodeIfPresent(String.self, forKey: .editedBy)
        editDate = try values.decodeIfPresent(String.self, forKey: .editDate)
    }

}
struct CurrentDirectoryModel : Codable {
    let directoryID : Int?
    let directoryName : String?

    enum CodingKeys: String, CodingKey {

        case directoryID = "DirectoryID"
        case directoryName = "DirectoryName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        directoryID = try values.decodeIfPresent(Int.self, forKey: .directoryID)
        directoryName = try values.decodeIfPresent(String.self, forKey: .directoryName)
    }

}

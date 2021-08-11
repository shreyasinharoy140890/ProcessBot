//
//  UserAgentBuilder.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 03/08/21.
//

import Foundation
import UIKit

struct UserAgentBuilder {
    
    static var DarwinVersion:String {
        var sysinfo = utsname()
        uname(&sysinfo)
        let dv = String(bytes: Data(bytes: &sysinfo.release, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
        return "Darwin/\(dv)"
    }
    //eg. CFNetwork/808.3
    static var CFNetworkVersion:String {
        let dictionary = Bundle(identifier: "com.apple.CFNetwork")?.infoDictionary!
        let version = dictionary?["CFBundleShortVersionString"] as! String
        return "CFNetwork/\(version)"
    }

    //eg. iOS/10_1
    static var deviceVersion:String {
        let currentDevice = UIDevice.current
        return "\(currentDevice.systemName)/\(currentDevice.systemVersion)"
    }
    //eg. iPhone5,2
    static var deviceName:String {
        var sysinfo = utsname()
        uname(&sysinfo)
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
    //eg. MyApp/1
    static var appNameAndVersion:String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let name = dictionary["CFBundleName"] as! String
        return "\(name)/\(version)"
    }

    static func UAString() -> String {
        return "\(UserAgentBuilder.appNameAndVersion) \(UserAgentBuilder.deviceName) \(UserAgentBuilder.deviceVersion) \(UserAgentBuilder.CFNetworkVersion) \(UserAgentBuilder.DarwinVersion)"
    }
}

//
//  ChartFormatter.swift
//  Process Bot
//
//  Created by Shreya Sinha Roy on 06/08/21.
//

import UIKit
import Charts

class ChartFormatter: NSObject,AxisValueFormatter {

    var months: [String]! = ["HR & CRM", "Finance"]

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    return months[Int(value)]
    }
}

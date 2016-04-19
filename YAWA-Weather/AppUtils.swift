//
//  AppUtils.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 4/15/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation

class AppUtils {
    
    static func calculateWindDirection(forDegrees: String) -> String
    {
        if let deg = Double(forDegrees) {
            let val = (deg / 22.5) + 0.5
            let directions = ["N","NNE","NE","ENE","E","ESE", "SE", "SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"]
            let index = Int(val % 16)
            return directions[index]
        } else {
            return ""
        }
    }
    
    static func getFormattedTimeString(forTimestampString timestamp:String) -> String
    {
        let now = NSDate(timeIntervalSince1970: Double(timestamp)!)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "H:mm a 'on' MMMM dd, yyyy"
        dateFormatter.AMSymbol = "AM"
        dateFormatter.PMSymbol = "PM"
        
        return dateFormatter.stringFromDate(now)
    }
}
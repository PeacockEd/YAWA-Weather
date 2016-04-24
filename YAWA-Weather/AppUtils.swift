//
//  AppUtils.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 4/15/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation

class AppUtils {
    
    static func calculateWindDirection(forDegrees: Double) -> String
    {
        let val = (forDegrees / 22.5) + 0.5
        let directions = ["N","NNE","NE","ENE","E","ESE", "SE", "SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"]
        let index = Int(val % 16)
        
        return directions[index]
    }
    
    static func getFormattedTimeString(forTimestamp timestamp:Double,
                                        withRawOffsetSeconds offset:Int,
                                        withDstOffset dstOffset:Int) -> String
    {
        let totalOffset = abs(offset + dstOffset)
        let hoursOffset = Double((totalOffset / 60) / 60)
        let now = NSDate(timeIntervalSince1970: timestamp)
        let adjustedDate = now.dateByAddingTimeInterval(-60 * 60 * hoursOffset)
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        dateFormatter.dateFormat = "h:mm a"
        //dateFormatter.dateFormat = "H:mm a 'on' MMMM dd, yyyy"
        dateFormatter.AMSymbol = "AM"
        dateFormatter.PMSymbol = "PM"
        
        return dateFormatter.stringFromDate(adjustedDate)
    }
    
    static func getFormattedTimeString(forTimestamp timestamp:Double) -> String
    {
        return getFormattedTimeString(forTimestamp: timestamp, withRawOffsetSeconds: 0, withDstOffset: 0)
    }
}
//
//  ForecastDayItem.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 4/13/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation

class ForecastDayItem {
    
    private var _dayName = ""
    private var _conditionsImageId = "00"
    private var _temperatureMin = 0.0
    private var _temperatureMax = 0.0
    private var _forecastTimestamp:Double?
    
    
    var dayName:String {
        get {
            return _dayName
        }
    }
    
    var conditionsImageId:String {
        get {
            return _conditionsImageId
        }
        set {
            _conditionsImageId = newValue
        }
    }
    
    var temperatureInfo:String {
        get {
            return "\(Int(_temperatureMin))\(DEGREES_SYMBOL)/\(Int(_temperatureMax))\(DEGREES_SYMBOL)"
        }
    }
    
    var temperatureMin:Double
    {
        get {
            return _temperatureMin
        }
        set {
            _temperatureMin = newValue
        }
    }
    
    var forecastMinTemp:String
        {
        get {
            return "\(Int(_temperatureMin))\(DEGREES_SYMBOL)"
        }
    }
    
    var temperatureMax:Double {
        get {
            return _temperatureMax
        }
        set {
            _temperatureMax = newValue
        }
    }
    
    var forecastMaxTemp:String
        {
        get {
            return "\(Int(_temperatureMax))\(DEGREES_SYMBOL)"
        }
    }
    
    var forecastTimestamp:Double
        {
        get {
            if _forecastTimestamp == nil {
                return NSDate().timeIntervalSince1970 * 1000
            }
            return _forecastTimestamp!
        }
        set {
            _forecastTimestamp = newValue
            calculateDayName()
        }
    }
    
    private func calculateDayName()
    {
        _dayName = ""
        if let time = _forecastTimestamp {
            let date = NSDate(timeIntervalSince1970: time)
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE"
            _dayName = formatter.stringFromDate(date).uppercaseString
        }
    }
}
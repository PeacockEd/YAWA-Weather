//
//  ForecastDayItem.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 4/13/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation

class ForecastDayItem {
    
    private var _dayName = "---"
    private var _conditionsImageId = "00"
    private var _temperatureInfo = "..."
    
    
    var dayName:String {
        get {
            return _dayName
        }
    }
    
    var conditionsImageId:String {
        get {
            return _conditionsImageId
        }
    }
    
    var temperatureInfo:String {
        get {
            return _temperatureInfo
        }
    }
}
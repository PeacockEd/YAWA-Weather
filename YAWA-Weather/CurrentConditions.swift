//
//  CurrentConditions.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 4/13/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation
import Alamofire

class CurrentConditions {
    
    // by zip
    // http://api.openweathermap.org/data/2.5/weather/?zip=94102,us&APPID=
    
    // by location data
    // http://api.openweathermap.org/data/2.5/weather/?lon=-134.3&lat=-80.12&APPID=
    
    private var _currentLocation = "..."
    private var _currentTemp = "--"
    private var _forecastHiTemp = "--"
    private var _forecastLoTemp = "--"
    private var _sunriseTime = "-:-- am"
    private var _sunsetTime = "-:-- pm"
    private var _conditionsImageId = "00"
    private var _windData = ""
    
    
    var currentLocation:String {
        get {
            return _currentLocation
        }
    }
    
    var currentTemp:String {
        get {
            return _currentTemp
        }
    }
    
    var forecastHiTemp:String {
        get {
            return _forecastHiTemp
        }
    }
    
    var forecastLoTemp:String {
        get {
            return _forecastLoTemp
        }
    }
    
    var sunriseTime:String {
        get {
            return _sunriseTime
        }
    }
    
    var sunsetTime:String {
        get {
            return _sunsetTime
        }
    }
    
    var conditionsImageId:String {
        get {
            return _conditionsImageId
        }
    }
    
    var windData:String {
        get {
            return _windData
        }
    }
    
    func requestCurrentConditions(forPostalCode postalCode:String, complete: DownloadComplete)
    {
        let weatherUrl = "\(CURRENT_WEATHER_URL)zip=\(postalCode),us&APPID=\(API_KEY)"
        let url = NSURL(string: weatherUrl)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            print(result.debugDescription)
            complete()
        }
    }
}
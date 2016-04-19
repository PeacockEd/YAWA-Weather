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
    
    private var _currentLocation = "Retrieving data ..."
    private var _currentTemp = ""
    private var _currentConditionsDesc = ""
    private var _humidity = ""
    private var _pressure = ""
    private var _forecastHiTemp = "--"
    private var _forecastLoTemp = "--"
    private var _sunriseTime = "-:-- am"
    private var _sunsetTime = "-:-- pm"
    private var _conditionsImageId = "00"
    private var _windDirection = ""
    private var _windSpeed = ""
    
    
    var currentLocation:String {
        get {
            return _currentLocation
        }
    }
    
    var currentConditionsDesc:String {
        get {
            return _currentConditionsDesc
        }
    }
    
    var currentTemp:String {
        get {
            return _currentTemp
        }
    }
    
    var humidity:String {
        get {
            return _humidity
        }
    }
    
    var pressure:String {
        get {
            return _pressure
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
    
    var windSpeed:String {
        get {
            return _windSpeed
        }
    }
    
    var windDirection:String {
        get {
            return _windDirection
        }
    }
    
    func requestCurrentConditions(forPostalCode postalCode:String, complete: DownloadComplete)
    {
        let weatherUrl = "\(CURRENT_WEATHER_URL)zip=\(postalCode),us&APPID=\(API_KEY)"
        let url = NSURL(string: weatherUrl)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            if let result = response.result.value {
                print(result.debugDescription)
                if let dict = result as? Dictionary<String, AnyObject> {
                    if let code = dict["cod"] as? String {
                        if code == "200" {
                            if let weather = dict["weather"] as? Dictionary<String, AnyObject> {
                                if let imageId = weather["icon"] as? String {
                                    self._conditionsImageId = imageId
                                }
                                if let description = weather["main"] as? String {
                                    self._currentConditionsDesc = description
                                }
                            }
                            if let wind = dict["wind"] as? Dictionary<String, AnyObject> {
                                if let direction = wind["deg"] as? String {
                                    self._windDirection = AppUtils.calculateWindDirection(direction)
                                }
                                if let speed = wind["speed"] as? String {
                                    self._windSpeed = speed
                                }
                            }
                        }
                    }
                }
            }
            complete()
        }
    }
}
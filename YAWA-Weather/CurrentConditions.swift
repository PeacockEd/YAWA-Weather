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
    private var _currentTemp = 0.0
    private var _currentConditionsDesc = ""
    private var _humidity = 0.0
    private var _pressure = 0.0
    private var _forecastHiTemp = 0.0
    private var _forecastLoTemp = 0.0
    private var _sunriseTime = 0.0
    private var _sunsetTime = 0.0
    private var _conditionsImageId = "00"
    private var _windDegrees = 0.0
    private var _windSpeed = 0.0
    
    private var _coords = ["lat": 0.0, "lon": 0.0]
    private var _timeOffset = 0
    private var _dstOffset = 0
    
    
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
            return "\(Int(_currentTemp))\(DEGREES_SYMBOL)"
        }
    }
    
    var humidity:String {
        get {
            return "\(Int(_humidity))"
        }
    }
    
    var pressure:String {
        get {
            return "\(Int(_pressure))"
        }
    }
    
    var forecastHiTemp:String {
        get {
            return "\(Int(_forecastHiTemp))\(DEGREES_SYMBOL)"
        }
    }
    
    var forecastLoTemp:String {
        get {
            return "\(Int(_forecastLoTemp))\(DEGREES_SYMBOL)"
        }
    }
    
    var sunriseTime:String {
        get {
            if _sunriseTime <= 0 {
                return "-:-- am"
            } else {
                return "\(AppUtils.getFormattedTimeString(forTimestamp: _sunriseTime, withRawOffsetSeconds: _timeOffset, withDstOffset: _dstOffset))"
            }
        }
    }
    
    var sunsetTime:String {
        get {
            if _sunsetTime <= 0 {
                return "-:-- pm"
            } else {
                return "\(AppUtils.getFormattedTimeString(forTimestamp: _sunsetTime, withRawOffsetSeconds: _timeOffset, withDstOffset: _dstOffset))"
            }
        }
    }
    
    var conditionsImageId:String {
        get {
            return _conditionsImageId
        }
    }
    
    var windSpeed:String {
        get {
            return "\(Int(_windSpeed))"
        }
    }
    
    var windDirection:String {
        get {
            return "\(AppUtils.calculateWindDirection(_windDegrees))"
        }
    }
    
    func requestCurrentConditions(forPostalCode postalCode:String, complete: DownloadComplete)
    {
        let weatherUrl = "\(CURRENT_WEATHER_URL)zip=\(postalCode),us&APPID=\(API_KEY)"
        let url = NSURL(string: weatherUrl)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            guard let result = response.result.value else {
                let err:DataError = .ServerError("Unexpected Response.")
                complete(err)
                return
            }
            guard let dict = result as? Dictionary<String, AnyObject>,
                let code = dict["cod"] as? Int where code == 200 else {
                    let err:DataError = .ServerError("Server responded with value other than 200.")
                    complete(err)
                    return
            }
            
            guard let coords = dict["coord"] as? Dictionary<String, AnyObject>,
                let lat = coords["lat"] as? Double,
                let lon = coords["lon"] as? Double else {
                    complete(DataError.FormatError("Data response in invalid format."))
                    return
            }
            self._coords["lat"] = lat
            self._coords["lon"] = lon
            
            guard let name = dict["name"] as? String else {
                complete(DataError.FormatError("Data response in invalid format."))
                return
            }
            self._currentLocation = name
            
            guard let main = dict["main"] as? Dictionary<String, AnyObject>,
                let humidity = main["humidity"] as? Double,
                let pressure = main["pressure"] as? Double,
                let temp = main["temp"] as? Double,
                let temp_min = main["temp_min"] as? Double,
                let temp_max = main["temp_max"] as? Double else {
                    complete(DataError.FormatError("Data response in invalid format."))
                    return
            }
            self._humidity = humidity
            self._pressure = pressure
            self._currentTemp = temp
            self._forecastLoTemp = temp_min
            self._forecastHiTemp = temp_max
            
            guard let sys = dict["sys"] as? Dictionary<String, AnyObject>,
                let sunrise = sys["sunrise"] as? Double,
                let sunset = sys["sunset"] as? Double else {
                    complete(DataError.FormatError("Data response in invalid format."))
                    return
            }
            self._sunriseTime = sunrise
            self._sunsetTime = sunset
            
            guard let weather = dict["weather"] as? [Dictionary<String, AnyObject>]
                where weather.count > 0,
                let imageId = weather[0]["icon"] as? String,
                let description = weather[0]["description"] as? String else {
                    complete(DataError.FormatError("Data response in invalid format."))
                    return
            }
            self._conditionsImageId = imageId
            self._currentConditionsDesc = description
            
            guard let wind = dict["wind"] as? Dictionary<String, AnyObject>,
                let direction = wind["deg"] as? Double,
                let speed = wind["speed"] as? Double else {
                    complete(DataError.FormatError("Data response in invalid format."))
                    return
            }
            self._windDegrees = direction
            self._windSpeed = speed
            
            let now = NSDate()
            let timeUrlStr = "\(GOOGLE_TIMEZONE_URL)location=\(self._coords["lat"]!),\(self._coords["lon"]!)&timestamp=\(Int(now.timeIntervalSince1970))&key=\(GOOGLE_API_KEY)"
            let timeUrl = NSURL(string: timeUrlStr)!
            
            Alamofire.request(.GET, timeUrl).responseJSON { response in
                guard let tz_resp = response.result.value else {
                    complete(DataError.ServerError("Data response in invalid format."))
                    return
                }
                guard let tz_dict = tz_resp as? Dictionary<String, AnyObject> else {
                    complete(DataError.FormatError("Data response in invalid format."))
                    return
                }
                guard let rawOffset = tz_dict["rawOffset"] as? Int,
                    let dstOffset = tz_dict["dstOffset"] as? Int else {
                        complete(DataError.FormatError("Data response in invalid format."))
                        return
                }
                self._timeOffset = rawOffset
                self._dstOffset = dstOffset
                
                complete(DataError.None)
            }
        }
    }
}
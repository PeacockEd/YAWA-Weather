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
    // http://api.openweathermap.org/data/2.5/weather/?zip=08527,us&APPID=
    
    // by location data
    // http://api.openweathermap.org/data/2.5/weather/?lon=-74.3&lat=40.12&APPID=

    private var _weatherUrl:String!
    
    init()
    {
        _weatherUrl = "\(CURRENT_WEATHER_URL)zip=94102,us&APPID=\(API_KEY)"
    }
    
    func requestCurrentConditions(complete: DownloadComplete)
    {
        let url = NSURL(string: _weatherUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            print(result.debugDescription)
        }
    }
}
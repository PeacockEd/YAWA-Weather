//
//  ForecastItems.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 4/15/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation
import Alamofire

class ForecastItems {
    
    // by zip
    // http://api.openweathermap.org/data/2.5/forecast?zip=94102,us&APPID=
    
    private var items:[ForecastDayItem]!
    
    init()
    {
        items = [ForecastDayItem](count: TOTAL_FORECAST_ITEMS, repeatedValue: ForecastDayItem())
    }
    
    func getForecastItem(forIndex index:Int) -> ForecastDayItem?
    {
        if items.count == 0 || index > items.count {
            return nil
        }
        return items[index]
    }
    
    func requestForecastData(forPostalCode postalCode:String, complete:DownloadComplete)
    {
        let weatherUrl = "\(FORECAST_WEATHER_URL)zip=\(postalCode),us&APPID=\(API_KEY)"
        let url = NSURL(string: weatherUrl)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            //print(result.debugDescription)
            //complete()
        }
    }
}

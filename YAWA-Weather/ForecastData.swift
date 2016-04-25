//
//  ForecastData.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 4/15/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation
import Alamofire

class ForecastData {
    
    private var items:[ForecastDayItem]!
    
    
    init()
    {
        items = [ForecastDayItem](count: TOTAL_FORECAST_ITEMS + 1, repeatedValue: ForecastDayItem())
    }
    
    func getForecastItem(forIndex index:Int) -> ForecastDayItem?
    {
        if items.count == 0 || index > items.count {
            return nil
        }
        return items[index]
    }
    
    func requestForecastData(forLocation loc:Dictionary<String, Double>, complete:DownloadComplete)
    {
        guard let lat = loc["lat"], let lng = loc["lng"] else {
            complete(DataError.FormatError("Unable to perform request."))
            return
        }
        
        let weatherUrl = "\(FORECAST_WEATHER_URL)lon=\(lng)&lat=\(lat)&APPID=\(API_KEY)"
        let url = NSURL(string: weatherUrl)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            guard let result = response.result.value else {
                let err:DataError = .ServerError("Unexpected Response.")
                complete(err)
                return
            }
            guard let dict = result as? Dictionary<String, AnyObject>,
                let code = dict["cod"] as? String where code == "200" else {
                    let err:DataError = .ServerError("Server responded with value other than 200.")
                    complete(err)
                    return
            }
            guard let list = dict["list"] as? [Dictionary<String, AnyObject>] where list.count > 0 else {
                let err:DataError = .FormatError("No forecast items returned from request.")
                complete(err)
                return
            }
            
            var dataItems = [ForecastDayItem]()
            for item in list {
                let dayItem = ForecastDayItem()
                guard let time = item["dt"] as? Double,
                    let weather = item["weather"] as? [Dictionary<String, AnyObject>] where weather.count > 0,
                    let temp = item["temp"] as? Dictionary<String, AnyObject> else {
                        let err:DataError = .FormatError("Data response in invalid format.")
                        complete(err)
                        return
                }
                guard let imageId = weather[0]["icon"] as? String,
                    let min = temp["min"] as? Double,
                    let max = temp["max"] as? Double else {
                        let err:DataError = .FormatError("Data response in invalid format.")
                        complete(err)
                        return
                }
                
                dayItem.conditionsImageId = imageId
                dayItem.temperatureMin = min
                dayItem.temperatureMax = max
                dayItem.forecastTimestamp = time
                dataItems.append(dayItem)
            }
            dataItems.sortInPlace { $0.forecastTimestamp < $1.forecastTimestamp }
            self.items = dataItems
            
            complete(DataError.None)
        }
    }
}

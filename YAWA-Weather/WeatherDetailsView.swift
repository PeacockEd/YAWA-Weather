//
//  WeatherDetailsView.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 4/9/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit

class WeatherDetailsView: UIView {
    
    @IBOutlet weak var todayImg:UIImageView!
    @IBOutlet weak var todayDescLabel:UILabel!
    @IBOutlet weak var todayTempLabel:UILabel!
    
    @IBOutlet weak var sunriseLabel:UILabel!
    @IBOutlet weak var sunsetLabel:UILabel!
    
    @IBOutlet weak var windLabel:UILabel!
    
    func updateUI(withCurrentConditions data:CurrentConditions,
                                        withForecastData forecastData:ForecastDayItem)
    {
        todayImg.image = UIImage(named: "\(data.conditionsImageId).png")
        todayDescLabel.text = data.currentConditionsDesc
        todayTempLabel.text = "Current: \(data.currentTemp)   Hi: \(forecastData.forecastMaxTemp)  Lo: \(forecastData.forecastMinTemp)"
        
        sunriseLabel.text = data.sunriseTime
        sunsetLabel.text = data.sunsetTime
        
        windLabel.text = "\(data.windDirection) @\(data.windSpeed) MPH"
    }
}

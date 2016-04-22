//
//  CurrentWeatherView.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 4/1/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit

class CurrentWeatherView: UIView {
    
    @IBOutlet weak var locationLabel:UILabel!
    @IBOutlet weak var conditionsImg:UIImageView!
    @IBOutlet weak var conditionsLabel:UILabel!
    @IBOutlet weak var temperatureLabel:UILabel!
    
    func updateUI(withCurrentConditions data: CurrentConditions)
    {
        locationLabel.text = data.currentLocation
        conditionsImg.image = UIImage(named: "\(data.conditionsImageId).png")
        conditionsLabel.text = data.currentConditionsDesc
        temperatureLabel.text = data.currentTemp
    }
}

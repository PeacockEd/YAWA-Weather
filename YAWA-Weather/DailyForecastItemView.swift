//
//  DailyForecastItemView.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 4/1/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit

class DailyForecastItemView: UIView {
    
    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var dayLbl:UILabel!
    @IBOutlet weak var forecastLbl:UILabel!
    
    override func awakeFromNib() {
        print("I am a DAY view!!")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

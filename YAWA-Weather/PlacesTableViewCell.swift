//
//  PlacesTableViewCell.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 4/25/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit

class PlacesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var placeLabel:UILabel!
    
    
    func configureCell(label:String)
    {
        placeLabel.text = label
    }
}

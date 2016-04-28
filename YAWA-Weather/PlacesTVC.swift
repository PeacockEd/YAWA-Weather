//
//  PlacesTVC.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 4/25/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation
import UIKit

class PlacesTVC: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private var placesTV:UITableView!
    private var _places = [Dictionary<String, String>]()
    
    
    init (tableViewTarget tv:UITableView)
    {
        super.init()
        
        placesTV = tv
        placesTV.dataSource = self
        placesTV.delegate = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return places.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if let cell = placesTV.dequeueReusableCellWithIdentifier("PlacesTableViewCell") as? PlacesTableViewCell {
            if let label = places[indexPath.row]["label"] {
                cell.configureCell(label)
            }
            return cell
        } else {
            return PlacesTableViewCell()
        }
    }
    
    var places:Array<Dictionary<String, String>>
    {
        get {
            return _places
        }
        set {
            _places = newValue
            placesTV.reloadData()
        }
    }
}

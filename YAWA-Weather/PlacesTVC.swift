//
//  PlacesTVC.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 4/25/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation
import UIKit

protocol PlacesDelegate: class {
    func userDidSelectPlace(placeLabel label:String, placeId id:String)
}

class PlacesTVC: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private var placesTV:UITableView!
    private var _places = [Dictionary<String, String>]()
    
    weak var delegate:PlacesDelegate?
    
    
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if let placeId = places[indexPath.row]["data"],
            let placeLabel = places[indexPath.row]["label"] {
            delegate?.userDidSelectPlace(placeLabel: placeLabel, placeId: placeId)
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

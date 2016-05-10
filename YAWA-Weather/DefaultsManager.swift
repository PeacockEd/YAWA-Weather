//
//  DefaultsManager.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 5/4/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation

struct Defaults {
    static let SavedLocation = "savedLocation"
    static let AppHasLaunchedBefore = "appHasLaunchedBefore"
}

class DefaultsManager {
    
    static func saveLocation(forCoords coords:SavedLocation)
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let lat = coords["lat"], let lng = coords["lng"] {
            defaults.setObject(["lat": lat, "lng": lng], forKey: Defaults.SavedLocation)
        }
    }
    
    static func getSavedLocation() -> SavedLocation?
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let location = defaults.objectForKey(Defaults.SavedLocation) {
            if let lat = location["lat"] as? Double, let lng = location["lng"] as? Double {
                return ["lat": lat, "lng": lng]
            }
        }
        return nil
    }
    
    static func getIsFirstLaunch() -> Bool
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.boolForKey(Defaults.AppHasLaunchedBefore) {
            return false
        }
        defaults.setBool(true, forKey: Defaults.AppHasLaunchedBefore)

        return true
    }
}

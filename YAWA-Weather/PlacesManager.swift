//
//  PlacesManager.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 4/24/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation
import Alamofire

class PlacesManager {
    
    class func getPlaceSuggestions(forInput input:String, complete:SuggestionsDownloadComplete)
    {
        var placesArray = [[String:String]]()
        
        // the "types" option set to "('cities')" restricts the response to just cities
        // instead of returning addresses
        Alamofire.request(.GET, GOOGLE_PLACES_AUTOCOMPLETE_URL, parameters: ["input":"\(input)", "types":"(cities)", "components":"country:us","key":GOOGLE_API_KEY]).responseJSON { (response) in
            guard let places = response.result.value else {
                complete(PlacesResult.Failure(DataError.ServerError("Unable to get places suggestions at this time.")))
                return
            }
            guard let dict = places as? Dictionary<String, AnyObject>,
                let status = dict["status"] as? String where status == "OK",
                let predictions = dict["predictions"] as? [Dictionary<String, AnyObject>] where predictions.count > 0 else {
                complete(PlacesResult.Failure(DataError.FormatError("Data response in invalid format.")))
                return
            }
            for item in predictions {
                if let placeLabel = item["description"] as? String,
                    let placeId = item["place_id"] as? String {
                    placesArray.append(["label":placeLabel, "data":placeId])
                }
            }
            complete(PlacesResult.Success(placesArray))
        }
    }
    
    class func getGeoDetails(forPlaceId id:String, complete:GeoDetailsDownloadComplete)
    {
        var geoArray = ["lat": 0.0, "lng": 0.0]
        
        Alamofire.request(.GET, GOOGLE_PLACES_DETAILS_URL, parameters: ["placeid": "\(id)", "key":GOOGLE_API_KEY]).responseJSON { (response) in
            guard let place = response.result.value else {
                complete(PlacesResult.Failure(DataError.ServerError("Unable to retrieve places info for id:\(id)")))
                return
            }
            guard let dict = place as? Dictionary<String, AnyObject>,
                let status = dict["status"] as? String where status == "OK",
                let result = dict["result"] as? Dictionary<String, AnyObject>,
                let geometry = result["geometry"] as? Dictionary<String, AnyObject>,
                let location = geometry["location"] as? Dictionary<String, AnyObject>,
                let lat = location["lat"] as? Double,
                let lng = location["lng"] as? Double else {
                    complete(PlacesResult.Failure(DataError.FormatError("Unable to parse place data for id:\(id)")))
                    return
            }
            
            geoArray["lat"] = lat
            geoArray["lng"] = lng
            complete(PlacesResult.Success(geoArray))
        }
    }
}
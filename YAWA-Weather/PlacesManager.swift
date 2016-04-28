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
    
    static func getPlaceSuggestions(forInput input:String, complete:SuggestionsDownloadComplete)
    {
        let url = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
        var placesArray = [[String:String]]()
        
        Alamofire.request(.GET, url, parameters: ["input":"\(input)", "types":"(cities)", "components":"country:us","key":GOOGLE_API_KEY]).responseJSON { (response) in
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
    
    static func getGeoDetails(forPlaceId:String, complete:GeoDetailsDownloadComplete)
    {
        let url = "https://maps.googleapis.com/maps/api/place/details/json"
        Alamofire.request(.GET, url, parameters: ["placeid": "", "key":GOOGLE_API_KEY]).responseJSON { (response) in
            // TODO: Handle error conditions
            //print(response.result.value)
        }
        complete(PlacesResult.Success([["":0.0]]))
    }
}
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
    
    func getPlaceSuggestions(forInput input:String) -> PlacesResult<SuggestionResponse, DataError>
    {
        let url = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
        Alamofire.request(.GET, url, parameters: ["input":"\(input)", "type":"geocode", "key":GOOGLE_API_KEY]).responseJSON { (response) in
            print(response.result.value)
        }
        return PlacesResult.Success(["":""])
    }
    
    func getGeoDetails(forPlaceId:String) -> PlacesResult<GeoDetailsResponse, DataError>
    {
        let url = "https://maps.googleapis.com/maps/api/place/details/json"
        Alamofire.request(.GET, url, parameters: ["placeid": "", "key":GOOGLE_API_KEY]).responseJSON { (response) in
            print(response.result.value)
        }

        return PlacesResult.Success(["":0.0])
    }
}
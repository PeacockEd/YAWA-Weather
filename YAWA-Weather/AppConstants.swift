//
//  AppConstants.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 4/13/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation

// YOU MUST OBTAIN YOUR OWN API KEY!
// SEE https://console.developers.google.com FOR MORE INFO
let GOOGLE_API_KEY = ""
let GOOGLE_TIMEZONE_URL = "https://maps.googleapis.com/maps/api/timezone/json?"

// YOU MUST OBTAIN YOUR OWN API KEY!
// SEE http://openweathermap.org/ FOR MORE INFO
let API_KEY = ""
let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather/?units=imperial&"
let FORECAST_WEATHER_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?cnt=4&units=imperial&"
let TOTAL_FORECAST_ITEMS = 3
let DEGREES_SYMBOL = "°"

typealias SuggestionResponse = [Dictionary<String, String>]
typealias GeoDetailsResponse = Dictionary<String, Double>
typealias DownloadComplete = (DataError) -> ()
typealias SuggestionsDownloadComplete = (PlacesResult<SuggestionResponse, DataError>) -> ()
typealias GeoDetailsDownloadComplete = (PlacesResult<GeoDetailsResponse, DataError>) -> ()
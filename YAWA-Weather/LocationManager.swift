//
//  LocationManager.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 4/14/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import Foundation
import MapKit

protocol WeatherLocationDelegate: class {
    func locationDidFailWithError(error:NSError?, message: LocationDetailsErrorMessage)
    func didUpdateToLocation(newLocation:CLLocation)
}

enum LocationDetailsErrorMessage: String {
    case LOCATION_NOT_SUPPORTED = "Only U.S. based locations are supported at this time."
    case LOCATION_FAILED_ERROR = "The app was unable to retrieve your current location. Please be sure to allow this application to use Location Services in the Settings menu."
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    weak var delegate:WeatherLocationDelegate?
    
    private let locationManager = CLLocationManager()
    //private var geoCoder = CLGeocoder()
    
    
    func getLocation()
    {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationAuthStatus()
    {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        delegate?.locationDidFailWithError(error, message: .LOCATION_FAILED_ERROR)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation)
    {
        // update location only on app launch
        delegate?.didUpdateToLocation(newLocation)
        locationManager.stopUpdatingLocation()
        
        /*
        geoCoder.reverseGeocodeLocation(newLocation) { (placemarks, error) in
            if error == nil {
                if let placemarks = placemarks where placemarks.count > 0 {
                    if let placemark = placemarks.last,
                        let postalCode = placemark.postalCode,
                        let country = placemark.country
                    {
                        // App only supports US locations at this time
                        if let range = country.rangeOfString("United States") where !range.isEmpty {
                            self._postalCode = postalCode
                            self.locationManager.stopUpdatingLocation()
                            self.delegate?.didUpdateToLocation(newLocation)
                        } else {
                            self.delegate?.locationDidFailWithError(nil, message: .LOCATION_NOT_SUPPORTED)
                        }
                    }
                }
            }
        }
        */
    }
    
    deinit
    {
        locationManager.stopUpdatingLocation()
    }
}
//
//  ViewController.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 3/30/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, WeatherLocationDelegate {
    
    private enum WeatherViewState: Int
    {
        case Current = 0, Details
    }
    
    @IBOutlet weak var searchBar:UISearchBar!
    @IBOutlet weak var segmentBar:UISegmentedControl!
    @IBOutlet weak var currentWeatherView:CurrentWeatherView!
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var detailsView:UIView!
    
    @IBOutlet weak var scrollingContainerHeightConstraint:NSLayoutConstraint!
    
    private var isErrorDialogOpen = false;
    private var currentConditions:CurrentConditions = CurrentConditions()
    private var forecastItems:[ForecastDayItem]?
    
    let locationManager = LocationManager()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        segmentBar.addTarget(self, action: #selector(ViewController.toggleView(_:)), forControlEvents: .ValueChanged)
        
        detailsView.hidden = true
        updateViewHeightForDevice()
        
        locationManager.delegate = self
        locationManager.getLocation()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        locationManager.locationAuthStatus()
    }
    
    override func viewDidLayoutSubviews()
    {
        scrollView.contentOffset.y = searchBar.bounds.size.height
    }
    
    func updateViewHeightForDevice()
    {
        let deviceType = UIDevice.currentDevice().userInterfaceIdiom
        switch deviceType {
        case .Pad:
            scrollingContainerHeightConstraint.constant = 750
        default:
            scrollingContainerHeightConstraint.constant = 525
        }
    }
    
    func toggleView(segmentControl: UISegmentedControl)
    {
        let index = segmentControl.selectedSegmentIndex
        if let viewToShow = WeatherViewState(rawValue: index) {
            switch viewToShow {
            case .Current:
                currentWeatherView.hidden = false
                detailsView.hidden = true
            case .Details:
                currentWeatherView.hidden = true
                detailsView.hidden = false
            }
        }
    }
    
    func showErrorPrompt(message: String)
    {
        if !isErrorDialogOpen {
            let alertController = UIAlertController(title: "Application Error", message: message, preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                self.isErrorDialogOpen = false
            }
            alertController.addAction(okAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            isErrorDialogOpen = true
        }
    }
    
    func locationDidFailWithError(error: NSError?, message: LocationDetailsErrorMessage)
    {
        showErrorPrompt(message.rawValue)
    }
    
    func didUpdateToLocation(newLocation: CLLocation)
    {
        if let postalCode = locationManager.postalCode {
            currentConditions.requestCurrentConditions(forPostalCode: postalCode) {
                // TODO: update UI with current conditions here!
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


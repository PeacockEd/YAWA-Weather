//
//  ViewController.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 3/30/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController
{
    private enum WeatherViewState: Int
    {
        case Current = 0, Details
    }
    
    @IBOutlet weak var refreshBtn:UIButton!
    @IBOutlet weak var searchBar:UISearchBar!
    @IBOutlet weak var suggestionsView: UIView!
    @IBOutlet weak var placesTV:UITableView!
    @IBOutlet weak var segmentBar:UISegmentedControl!
    @IBOutlet weak var currentWeatherView:CurrentWeatherView!
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var detailsView:WeatherDetailsView!
    @IBOutlet var forecastViewItems: [DailyForecastItemView]!
    
    @IBOutlet weak var scrollingContainerHeightConstraint:NSLayoutConstraint!
    
    private var isErrorDialogOpen = false;
    private var currentConditions = CurrentConditions()
    private var forecastData = ForecastData()
    
    let locationManager = LocationManager()
    private var placesController:PlacesTVC!
    
    private var firstView = true
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        suggestionsView.hidden = true
        placesController = PlacesTVC(tableViewTarget: placesTV)
        placesController.delegate = self
        
        segmentBar.addTarget(self, action: #selector(ViewController.toggleView(_:)), forControlEvents: .ValueChanged)
        
        searchBar.delegate = self
        scrollView.delegate = self
        
        refreshBtn.enabled = false
        detailsView.hidden = true
        updateViewHeightForDevice()
        
        updateUI()
        
        locationManager.delegate = self
        locationManager.getLocation()
        
        let touch = UITapGestureRecognizer(target: self, action: #selector(ViewController.onTouchRecognized))
        scrollView.addGestureRecognizer(touch)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        locationManager.locationAuthStatus()
    }
    
    override func viewDidLayoutSubviews()
    {
        if firstView {
            updateScrollYPosition(newY: searchBar.bounds.size.height, withAnimation: false)
            firstView = false
        }
    }
    
    @IBAction func onTapRefresh(sender:UIButton)
    {
        
    }
    
    private func updateUI()
    {
        currentWeatherView.updateUI(withCurrentConditions: currentConditions)
        detailsView.updateUI(withCurrentConditions: currentConditions, withForecastData: forecastData.getForecastItem(forIndex: 0) ?? ForecastDayItem())
        
        for item in forecastViewItems {
            let tag = item.tag + 1
            if let data = forecastData.getForecastItem(forIndex: tag) {
                item.data = data
            }
        }
    }
    
    func updateScrollYPosition(newY y:CGFloat, withAnimation animated:Bool)
    {
        scrollView.setContentOffset(CGPointMake(0.0, y), animated: animated)
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
    
    func showErrorPrompt(message: String, okAction: ((_:UIAlertAction) -> ())?)
    {
        if !isErrorDialogOpen {
            let alertController = UIAlertController(title: "Application Error", message: message, preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                self.isErrorDialogOpen = false
                
                if let okAction = okAction {
                    okAction(action)
                }
            }
            alertController.addAction(okAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            isErrorDialogOpen = true
        }
    }
    
    func fetchWeatherData(forLat lat: Double, forLong lng:Double)
    {
        if ConnectionManager.isConnectedToNetwork() {
            let locPoint = ["lat": lat, "lng": lng]
            
            currentConditions.requestCurrentConditions(forLocation: locPoint, complete: { (error) in
                guard error.errorCondition == nil else {
                    // TODO: Handle error someway/somehow
                    print("error!! \(error.errorCondition!)")
                    return
                }
                self.forecastData.requestForecastData(forLocation: locPoint, complete: { (error) in
                    guard error.errorCondition == nil else {
                        // TODO: Handle error someway/somehow
                        print("error 2!! \(error.errorCondition!)")
                        return
                    }
                    self.updateUI()
                })
            })
        } else {
            showErrorPrompt(CONNECTION_NOT_AVAIL_MSG, okAction: nil)
        }
    }
    
    func dismissLocationWarning(action:UIAlertAction)
    {
        if let lat = DEFAULT_LOCATION["lat"],
            let lng = DEFAULT_LOCATION["lng"] {
            fetchWeatherData(forLat: lat, forLong: lng)
        }
    }
    
    func getGeoDetails(forPlaceId id:String)
    {
        PlacesManager.getGeoDetails(forPlaceId: id) { (response) in
            guard response.error == nil else {
                // TODO: Handle error somehow
                print(response.error!)
                return
            }
            if let result = response.value,
                let lat = result["lat"],
                let lng = result["lng"] {
                self.fetchWeatherData(forLat: lat, forLong: lng)
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        view.endEditing(true)
    }
    
    func onTouchRecognized()
    {
        view.endEditing(true)
    }
}

extension ViewController: WeatherLocationDelegate
{
    func didUpdateToLocation(newLocation: CLLocation)
    {
        fetchWeatherData(forLat: newLocation.coordinate.latitude, forLong: newLocation.coordinate.longitude)
    }
    
    func locationDidFailWithError(error: NSError?, message: LocationDetailsErrorMessage)
    {
        showErrorPrompt(message.rawValue, okAction: dismissLocationWarning)
    }
}

extension ViewController: UIScrollViewDelegate
{
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        let offset = scrollView.contentOffset.y
        
        if offset > 0 && offset < searchBar.bounds.size.height {
            updateScrollYPosition(newY: 0.0, withAnimation: true)
        }
    }
}

extension ViewController: UISearchBarDelegate
{
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText.isEmpty {
            placesController.places = []
            suggestionsView.hidden = true
            scrollView.scrollEnabled = true
        } else {
            if ConnectionManager.isConnectedToNetwork() {
                PlacesManager.getPlaceSuggestions(forInput: searchText) { (result) in
                    guard result.error == nil else {
                        // TODO: Handle error condition
                        print(result.error?.errorCondition!)
                        return
                    }
                    if let places = result.value {
                        self.suggestionsView.hidden = false
                        self.scrollView.scrollEnabled = false
                        self.placesController.places = places
                    }
                }
            }
        }
    }
}

extension ViewController: PlacesDelegate
{
    func userDidSelectPlace(placeLabel label: String, placeId id: String)
    {
        if ConnectionManager.isConnectedToNetwork() {
            searchBar.text = ""
            placesController.places = []
            suggestionsView.hidden = true
            scrollView.scrollEnabled = true
            
            updateScrollYPosition(newY: searchBar.bounds.size.height, withAnimation: false)
            view.endEditing(true)
            
            getGeoDetails(forPlaceId: id)
        }
    }
}

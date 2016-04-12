//
//  ViewController.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 3/30/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        segmentBar.addTarget(self, action: #selector(ViewController.toggleView(_:)), forControlEvents: .ValueChanged)
        
        detailsView.hidden = true
        updateViewHeightForDevice()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


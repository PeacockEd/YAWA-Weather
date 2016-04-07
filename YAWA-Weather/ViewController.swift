//
//  ViewController.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 3/30/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar:UISearchBar!
    @IBOutlet weak var segmentBar:UISegmentedControl!
    @IBOutlet weak var currentWeatherView:CurrentWeatherView!
    @IBOutlet weak var scrollView:UIScrollView!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("LOAD!")
    }
    
    override func viewDidLayoutSubviews()
    {
        scrollView.contentOffset.y = searchBar.bounds.size.height
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


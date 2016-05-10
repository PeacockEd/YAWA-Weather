//
//  TutorialView.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 5/10/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit

protocol LaunchTutorialDismissedDelegate: class {
    func didDismissLaunchTutorial()
}

class TutorialView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var okBtn:UIButton!
    
    weak var delegate: LaunchTutorialDismissedDelegate?
    
    
    func beginTutorial()
    {
        imageView.image = UIImage(named: "tutorial01.png")
        
        let _ = NSTimer.scheduledTimerWithTimeInterval(3.5, target: self, selector: #selector(TutorialView.onPartOneTimer), userInfo: nil, repeats: false)
    }
    
    func onPartOneTimer()
    {
        imageView.image = UIImage(named: "tutorial02.png")
        
        let animation = CATransition()
        animation.type = kCATransitionFade
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.duration = 0.35
        
        imageView.layer.addAnimation(animation, forKey: nil)
        
        let _ = NSTimer.scheduledTimerWithTimeInterval(3.5, target: self, selector: #selector(TutorialView.onPartTwoTimer), userInfo: nil, repeats: false)
    }
    
    func onPartTwoTimer()
    {
        okBtn.hidden = false
        
        let animation = CATransition()
        animation.type = kCATransitionFade
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.duration = 0.35
        
        okBtn.layer.addAnimation(animation, forKey: nil)
    }
    
    @IBAction func onOkTapped(sender: UIButton)
    {
        delegate?.didDismissLaunchTutorial()
    }
}

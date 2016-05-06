//
//  LoadingAnimationView.swift
//  YAWA-Weather
//
//  Created by Edward P. Kelly on 5/5/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//

import UIKit

class LoadingAnimationView: UIView {
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    convenience init(targetView:UIView)
    {
        self.init(frame: targetView.bounds)
        insertLoadingAnimation(insideView: targetView)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("This class does not support NSCoding")
    }
    
    func insertLoadingAnimation(insideView target:UIView)
    {
        let background = UIImageView(image: addBackground())
        background.alpha = 0.7
        self.addSubview(background)
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        indicator.autoresizingMask = [.FlexibleTopMargin, .FlexibleRightMargin, .FlexibleBottomMargin, .FlexibleLeftMargin]
        indicator.center = target.center
        self.addSubview(indicator)
        
        indicator.startAnimating()
        
        target.addSubview(self)
        
        let animation = CATransition()
        animation.type = kCATransitionFade
        superview?.layer.addAnimation(animation, forKey: "layerAnimation")
    }
    
    func addBackground() -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 1.0)
        let num_locations:size_t = 2
        let locations: [CGFloat] = [0.0, 1.0]
        let components: [CGFloat] = [0.4, 0.4, 0.4, 0.8, 0.1, 0.1, 0.1, 0.5]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let myGradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, num_locations)
        let myRadius:CGFloat = (self.bounds.size.width*0.8)/2
        CGContextDrawRadialGradient(UIGraphicsGetCurrentContext(), myGradient, self.center, 0, self.center, myRadius, .DrawsAfterEndLocation)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        return image
    }
    
    func removeLoadingAnimation()
    {
        let animation = CATransition()
        animation.type = kCATransitionFade
        superview?.layer.addAnimation(animation, forKey: "layerAnimation")
        
        removeFromSuperview()
    }
}

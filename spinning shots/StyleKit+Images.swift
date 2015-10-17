//
//  StyleKit+Images.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-08.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import UIKit

extension StyleKit {
    
    public class func imageOfCannon(size size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        drawCannon(frame: CGRectMake(0, 0, size.width, size.height), cannonColor: Colors.Cannon, cannonStrokeColor: Colors.Stroke)
        
        let imageOfCannon = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageOfCannon
    }
    
    public class func imageOfBullet(size size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        drawBullet(frame: CGRectMake(0, 0, size.width, size.height), bulletColor: Colors.Bullet)
        
        let imageOfBullet = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageOfBullet
    }
    
    public class func imageOfPlayButton(diameter diameter: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(diameter: diameter), false, 0)
        drawPlayButton(buttonFillColor: Colors.Cannon, buttonStrokeColor: Colors.Stroke, buttonFrameDiameter: diameter)
        
        let imageOfPlayButton = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageOfPlayButton
    }
    
}
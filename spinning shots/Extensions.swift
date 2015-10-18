//
//  Extensions.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import UIKit
import SpriteKit

extension CGFloat {
    static func randomBetween(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + fmin(firstNum, secondNum)
    }
}

extension CGSize {
    
    var middle: CGPoint {
        return CGPoint(x: width / 2.0, y: height / 2.0)
    }
    
    init(diameter: CGFloat) {
        self.init(width: diameter, height: diameter)
    }
    
}

extension SKSpriteNode {
    func moveBy(velocity: CGPoint, dt: NSTimeInterval) {
        let amountToMove = CGPoint(x: velocity.x * CGFloat(dt), y: velocity.y * CGFloat(dt))
        self.position = CGPoint(x: self.position.x + amountToMove.x, y: self.position.y + amountToMove.y)
    }
}

extension SKAction {
    static var popAction: SKAction {
        let scaleUpDuration = ActionDuration / 5.0
        let scaleDownDuration = ActionDuration - scaleUpDuration
        let scaleUp = SKAction.scaleTo(1.1, duration: scaleUpDuration)
        let scaleDown = SKAction.scaleTo(0.0, duration: scaleDownDuration)
        let fadeOut = SKAction.fadeOutWithDuration(scaleDownDuration)
        let scaleSequence = SKAction.sequence([scaleUp, SKAction.group([scaleDown, fadeOut])])
        return SKAction.sequence([scaleSequence, SKAction.removeFromParent()])
    }
    
    static var tapAction: SKAction {
        let scaleUpDuration = ActionDuration / 5.0
        let scaleDownDuration = ActionDuration / 5.0
        let scaleUp = SKAction.scaleTo(1.1, duration: scaleUpDuration)
        let scaleDown = SKAction.scaleTo(1.0, duration: scaleDownDuration)
        return SKAction.sequence([scaleUp, scaleDown])
    }
    
    static func fadeInAndScaleUp(duration: NSTimeInterval) -> SKAction {
        let fadeIn = SKAction.fadeAlphaTo(1.0, duration: duration)
        let scaleUp = SKAction.scaleTo(1.0, duration: duration)
        return SKAction.group([fadeIn, scaleUp])
    }
}

extension UIColor {
    convenience init(hex: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if hex.hasPrefix("#") {
            let index   = hex.startIndex.advancedBy(1)
            let hex     = hex.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                switch (hex.characters.count) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    break
                }
            }
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
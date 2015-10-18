//
//  Values.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import UIKit

public class Values {
    public static let sharedValues = Values()
    
    public let sizes: Sizes
    public let positions: Positions
    public let speeds: Speeds
    
    init() {
        self.sizes = Sizes()
        self.positions = Positions(sizes: sizes)
        self.speeds = Speeds(sizes: sizes)
        
        InstanceCountingInitInstance(self)
    }
}

public struct Sizes {
    public let Screen: CGSize
    
    public let PlayingAreaDiameter: CGFloat
    public let BorderDiameter: CGFloat
    public let BorderStrokeWidth: CGFloat
    
    public let Cannon: CGSize
    public let Bullet: CGSize
    public let TargetThickness: CGFloat
    
    public let MenuButtonPlayDiameter: CGFloat
    public let GameOverButtonHomeDiameter: CGFloat
    public let GameOverButtonShareDiameter: CGFloat
    public let GameOverButtonGameCenterDiameter: CGFloat
    
    public let PlayingScoreLabelSize: CGFloat
    
    private init() {
        let delegate = UIApplication.sharedApplication().delegate! as! AppDelegate
        let gameVC = delegate.window!.rootViewController as! ViewController
        
        Screen = gameVC.view.frame.size
        
        PlayingAreaDiameter = Screen.width * 0.9
        BorderDiameter = PlayingAreaDiameter
        BorderStrokeWidth = 3.0
        
        let cannonHeight = round(PlayingAreaDiameter * 0.1)
        let cannonWidth = round(cannonHeight * 0.8)
        Cannon = CGSize(width: cannonWidth, height: cannonHeight)
        
        let bulletHeight = round(cannonHeight * 0.75)
        let bulletWidth = round(bulletHeight * 0.4)
        
        Bullet = CGSize(width: bulletWidth, height: bulletHeight)
        
        TargetThickness = cannonHeight * 0.5
        
        MenuButtonPlayDiameter = PlayingAreaDiameter * 0.4
        
        PlayingScoreLabelSize = PlayingAreaDiameter * 0.2

        GameOverButtonHomeDiameter = PlayingAreaDiameter * 0.25
        GameOverButtonShareDiameter = GameOverButtonHomeDiameter * 0.75
        GameOverButtonGameCenterDiameter = GameOverButtonHomeDiameter * 0.75
    }
}

public struct Positions {
    public let ScreenMiddle: CGPoint
    public let OvalBorderNode: CGPoint
    public let Cannon: CGPoint
    public let CannonBullet: CGPoint
    
    public let GameOverHomeButton: CGPoint
    public let GameOverShareButton: CGPoint
    public let GameOverGameCenterButton: CGPoint
    
    private init(sizes: Sizes) {
        ScreenMiddle = sizes.Screen.middle
        OvalBorderNode = CGPoint(x: (sizes.Screen.width - sizes.BorderDiameter) / 2.0, y: sizes.Screen.middle.y - sizes.BorderDiameter / 2.0)
        Cannon = ScreenMiddle
        CannonBullet = CGPoint(x: Cannon.x, y: Cannon.y + sizes.Cannon.height * 0.33)
        
        let buttonBottomOffset: CGFloat = 32.0
        let buttonBetweenOffset: CGFloat = sizes.GameOverButtonHomeDiameter / 2.0 + sizes.GameOverButtonShareDiameter / 2.0 + 16.0
        let gameOverButtonPosY = sizes.GameOverButtonHomeDiameter / 2.0 + buttonBottomOffset
        GameOverHomeButton = CGPoint(x: ScreenMiddle.x, y: gameOverButtonPosY)
        GameOverShareButton = CGPoint(x: GameOverHomeButton.x - buttonBetweenOffset, y: gameOverButtonPosY)
        GameOverGameCenterButton = CGPoint(x: GameOverHomeButton.x + buttonBetweenOffset, y: gameOverButtonPosY)
    }
}

public struct Speeds {
    public let Bullet: CGFloat
    public let Target: CGFloat
    
    private init(sizes: Sizes) {
        Bullet = sizes.PlayingAreaDiameter * 1.5
        Target = sizes.PlayingAreaDiameter * 0.0075
    }
}
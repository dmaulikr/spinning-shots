//
//  TargetPatternCreator.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-11-07.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

public class TargetPatternCreator {
    /**
     Create a pattern of targets for a game stage and style.
     - parameter stage: game stage
     - parameter style: game stage style
     - returns: pattern of targets
     */
    public static func patternForStageStyle(style: GameStageStyle) -> TargetPattern {
        switch style {
        case .Normal: return normalPattern()
        case .Bonus: return bonusPattern()
        }
    }
    
    /**
     Creates a pattern of targets for a stage with style HalfSpin.
     - parameter stage: game stage
     - returns: pattern of targets
     */
    private static func normalPattern() -> TargetPattern {
        let MIN_SIZE: CGFloat = 10.0
        let MAX_SIZE: CGFloat = 40.0
        let sizeRange = MAX_SIZE - MIN_SIZE
        let random = CGFloat.randomBetween(0.0, and: sizeRange)
        let targetSize = MIN_SIZE + random
        
        return TargetPattern(targetCount: 1, targetSize: targetSize)
    }
    
    /**
     Creates a pattern of targets for a stage with style FullSpin.
     - parameter stage: game stage
     - returns: pattern of targets
     */
    private static func bonusPattern() -> TargetPattern {
        let MIN_SIZE: CGFloat = 15.0
        let MAX_SIZE: CGFloat = 30.0
        let targetSize = CGFloat.randomBetween(MIN_SIZE, and: MAX_SIZE)
        let targetCount = CGFloat.randomBetween(3, and: 8)
        
        return TargetPattern(targetCount: Int(targetCount), targetSize: targetSize)
    }
    
}

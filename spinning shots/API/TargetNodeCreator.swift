//
//  TargetNodeCreator.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-16.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

/**
 Helper to create target nodes.
 */
public class TargetNodeCreator {
    
    /**
     Create a target node.
     - parameter degrees: size of target
     - parameter rotation: rotation of target
     - returns: target node
     */
    public static func create(degrees: CGFloat, rotation: CGFloat) -> TargetNode {
        let sizes = Values.sharedValues.sizes
        let target = Target(degrees: degrees, rotation: rotation)
        return TargetNode(target: target, thickness: sizes.TargetThickness, inRectWithDiameter: sizes.PlayingAreaDiameter)
    }
    
    /**
     Create a collection of target nodes from a pattern.
     - parameter pattern: pattern of targets
     - returns: collection of target nodes
     */
    public static func create(pattern: TargetPattern) -> [TargetNode] {
        var targetNodes = [TargetNode]()
        for i in 0..<pattern.count {
            let targetNode = TargetNodeCreator.create(pattern.targetSize, rotation: pattern.targets[i].rotation)
            targetNodes.append(targetNode)
        }
        return targetNodes
    }
    
    /**
     Create a pattern of targets for a game stage.
     - parameter stage: game stage
     - returns: pattern of targets
     */
    public static func patternForStage(stage: Int) -> TargetPattern {
        // TODO: tweak values
        if stage % 2 == 1 { // TODO: should be anchored in core game logic directly
            return TargetPattern(targetCount: stage + 2, gap: 15 * (1 + CGFloat(stage) / 10.0))
        } else {
            return TargetPattern(targetCount: 1, targetSize: 30.0 / (1 + CGFloat(stage) / 10.0))
        }
    }
    
}
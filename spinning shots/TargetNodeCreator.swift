//
//  TargetNodeCreator.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-16.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

public class TargetNodeCreator {
    
    public static func create(degrees: CGFloat, rotation: CGFloat) -> TargetNode {
        let sizes = Values.sharedValues.sizes
        let target = Target(degrees: degrees, rotation: rotation)
        return TargetNode(target: target, thickness: sizes.TargetThickness, inRectWithDiameter: sizes.PlayingAreaDiameter)
    }
    
    public static func create(pattern: TargetPattern) -> [TargetNode] {
        var targetNodes = [TargetNode]()
        for i in 0..<pattern.count {
            let targetNode = TargetNodeCreator.create(pattern.targetSize, rotation: pattern.targets[i].rotation)
            targetNodes.append(targetNode)
        }
        return targetNodes
    }
    
}
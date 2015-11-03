//
//  OvalBorderNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-09.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

/**
 Border node for the playing area.
 */
public class OvalBorderNode: SKShapeNode {
    
    /**
     Create a border node.
     - parameter diameter: diameter of the circle
     - parameter strokeWidth: width of the stroke
     */
    public init(diameter: CGFloat, strokeWidth: CGFloat) {
        super.init()
        
        // draw the circle
        let radius = diameter - strokeWidth
        let rect = CGRect(origin: CGPoint(x: strokeWidth / 2.0, y: strokeWidth / 2.0), size: CGSize(diameter: radius))
        path = CGPathCreateWithEllipseInRect(rect, nil)
        strokeColor = Colors.Target
        lineWidth = strokeWidth
        
        zPosition = ZPositions.OvalBorder
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) not implemented")
    }
    
}

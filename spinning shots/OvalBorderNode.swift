//
//  OvalBorderNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-09.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

public class OvalBorderNode: SKShapeNode {
    
    public init(diameter: CGFloat, strokeWidth: CGFloat) {
        super.init()
        
        let radius = diameter - strokeWidth
        let rect = CGRect(origin: CGPoint(x: strokeWidth / 2.0, y: strokeWidth / 2.0), size: CGSize(diameter: radius))
        path = CGPathCreateWithEllipseInRect(rect, nil)
        strokeColor = Colors.Clear
        lineWidth = strokeWidth
        
        zPosition = ZPositions.OvalBorder
        alpha = 0.25
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) not implemented")
    }
    
}

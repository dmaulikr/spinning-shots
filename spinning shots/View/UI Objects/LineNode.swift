//
//  LineNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-22.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

/**
 Orientation a line can be in.
 */
public enum LineOrientation {
    case Horizontal
    case Vertical
}

/**
 Node showing a simple line.
 */
public class LineNode: SKShapeNode {
    
    /**
     Create a line node.
     - parameter length: length of the line
     - parameter orientation: orientation of the line
     */
    public init(length: CGFloat, orientation: LineOrientation) {
        // draw the path of the line
        // - the line's middle is in the node's center
        let linePath = CGPathCreateMutable()
        let half = length / 2.0
        
        let x1, x2: CGFloat
        let y1, y2: CGFloat
        
        switch orientation {
        case .Horizontal:
            x1 = -half
            y1 = 0.0
            
            x2 = half
            y2 = 0.0
        case .Vertical:
            x1 = 0.0
            y1 = -half
            
            x2 = 0.0
            y2 = half
        }
        
        CGPathMoveToPoint(linePath, nil, x1, y1)
        CGPathAddLineToPoint(linePath, nil, x2, y2)
        
        super.init()
        
        path = linePath
        strokeColor = Colors.Clear
        lineWidth = 2.0
        
        // create the physics body for the collision detection
        // -> chose a rectangle body with a height of 1 because a simple line body didn't work (collision not detected)
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: length, height: 1.0), center: position)
        physicsBody?.categoryBitMask = EntityType.CollisionMarker.rawValue
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = EntityType.Target.rawValue
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


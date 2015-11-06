//
//  TargetNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

/**
 Visual representation of a target entity.
 */
public class TargetNode: ArcNode {
    
    public var target: Target
    public var shouldRotate: Bool
    
    /**
     Create a target node.
     - parameter target: model reprentation of the target
     - parameter thickness: stroke width
     - parameter diameter: diameter of this arc's circle
     */
    public init(target: Target, thickness: CGFloat, inRectWithDiameter diameter: CGFloat) {
        self.target = target
        self.shouldRotate = false
        
        super.init(rotation: target.rotation, degrees: target.degrees, thickness: thickness, inRectWithDiameter: diameter)
        
        
        // create a  physicsBody for the collision detection
        //
        // since the node is actually just a bent line with a thick stroke,
        // we need to manually create two physic bodies along the top and bottom of the stroke
        let outerPhysicsBody = physicsBodyWithRadius(diameter / 2.0)
        let innerPhysicsBody = physicsBodyWithRadius(diameter / 2.0 - thickness)
        
        physicsBody = SKPhysicsBody(bodies: [outerPhysicsBody, innerPhysicsBody])
        physicsBody?.categoryBitMask = EntityType.Target.rawValue
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = EntityType.CollisionMarker.rawValue
        
        zPosition = ZPositions.Target
    }
    
    /**
     Create a physics body for the arc.
     - parameter r: radius of the arc
     */
    private func physicsBodyWithRadius(r: CGFloat) -> SKPhysicsBody {
        return SKPhysicsBody(edgeChainFromPath: UIBezierPath(arcCenter: .zero, radius: r, startAngle: startAngle, endAngle: endAngle, clockwise: true).CGPath)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
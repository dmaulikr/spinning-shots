//
//  TargetNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

public class TargetNode: SKShapeNode {
    
    public var target: Target
    public var shouldRotate: Bool
    
    public init(target: Target, thickness: CGFloat, inRectWithDiameter diameter: CGFloat) {
        self.target = target
        self.shouldRotate = false

        super.init()
        
        let start = (0.0 + target.rotation - target.degrees / 2.0) * CGFloat(M_PI)/180
        let end = (target.degrees + target.rotation - target.degrees / 2.0) * CGFloat(M_PI)/180
        let radius = diameter / 2.0 - thickness / 2.0
        path = UIBezierPath(arcCenter: CGPoint.zero, radius: radius, startAngle: start, endAngle: end, clockwise: true).CGPath
        
        strokeColor = Colors.Target
        lineWidth = thickness
        
        let outerRadius = diameter / 2.0
        let outerPath = UIBezierPath(arcCenter: .zero, radius: outerRadius, startAngle: start, endAngle: end, clockwise: true)
        let outerBody = SKPhysicsBody(edgeChainFromPath: outerPath.CGPath)
        
        let innerRadius = diameter / 2.0 - thickness
        let innerPath = UIBezierPath(arcCenter: .zero, radius: innerRadius, startAngle: start, endAngle: end, clockwise: true)
        let innerBody = SKPhysicsBody(edgeChainFromPath: innerPath.CGPath)
        
        physicsBody = SKPhysicsBody(bodies: [outerBody, innerBody])
        physicsBody?.categoryBitMask = EntityType.Target.rawValue
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = EntityType.Bullet.rawValue
        
        zPosition = ZPositions.Target
        
        InstanceCountingInitInstance(self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
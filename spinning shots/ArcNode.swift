//
//  ArcNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-11-04.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

/**
 Arced line on a circle.
 */
public class ArcNode: SKShapeNode {
    
    private let radius: CGFloat
    private let rotation: CGFloat
    private let degrees: CGFloat
    internal let startAngle: CGFloat
    internal let endAngle: CGFloat
    
    /**
     Create a arc node.
     - parameter rotation: position of the arc on the circle (in degrees)
     - parameter degrees: length of the arc
     - parameter thickness: stroke width of the line
     - parameter diameter: diameter of this arc's circle
     */
    public init(rotation: CGFloat, degrees: CGFloat, thickness: CGFloat, inRectWithDiameter diameter: CGFloat) {
        self.rotation = rotation
        self.degrees = degrees
        self.radius = diameter / 2.0 - thickness / 2.0
        
        self.startAngle = (0.0 + rotation - degrees / 2.0) * CGFloat(M_PI)/180
        self.endAngle = (degrees + rotation - degrees / 2.0) * CGFloat(M_PI)/180
        
        super.init()
        
        path = UIBezierPath(arcCenter: CGPoint.zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).CGPath
        
        strokeColor = Colors.Target
        lineWidth = thickness
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

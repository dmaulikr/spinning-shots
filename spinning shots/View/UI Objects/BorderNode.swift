//
//  BorderNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-09.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

/**
 Border node for the playing area.
 
 Can be toggled to be either a full circle, or a half circle.
 */
public class BorderNode: SKSpriteNode {
    
    private(set) public var isFullCircle: Bool
    
    private var upperHalf: ArcNode!
    private var lowerHalf: ArcNode!
    
    /**
     Create a border node.
     */
    public init(isFullCircle: Bool) {
        self.isFullCircle = isFullCircle
        
        let sizes = Values.sharedValues.sizes
        
        super.init(texture: nil, color: Colors.Background, size: CGSize(diameter: sizes.BorderDiameter))
        
        let thickness = sizes.BorderStrokeWidth
        upperHalf = createArcNode(thickness: thickness)
        lowerHalf = createArcNode(thickness: thickness, rotated: true)
        
        addChild(upperHalf)
        addChild(lowerHalf)
        
        zPosition = ZPositions.OvalBorder
    }
    
    private func createArcNode(thickness thickness: CGFloat, rotated: Bool = false) -> ArcNode {
        let rotation: CGFloat = 90.0 + (rotated ? 180 : 0.0 )
        let degrees: CGFloat = 180.0
        
        let arcNode = ArcNode(rotation: rotation, degrees: degrees, thickness: thickness, inRectWithDiameter: size.width)
        
        return arcNode
    }
    
    public func toggleTransformation(animated animated: Bool = true) {
        isFullCircle = !isFullCircle
        
        if isFullCircle {
            addChild(lowerHalf)
        }
        
        if animated {
            lowerHalf.runAction(SKAction.rotateByAngle(CGFloat(M_PI), duration: ActionDuration)) {
                if !self.isFullCircle {
                    self.lowerHalf.removeFromParent()
                }
            }
        } else if !isFullCircle {
            lowerHalf.removeFromParent()
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) not implemented")
    }
    
}

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
    
    private(set) public var gameStageStyle: GameStageStyle  // the border adjusts its appearance to this value
    private var borderArc: ArcNode!                         // full circle arc
    private var overlay: SKSpriteNode!                      // overlay to change the border appearance
    
    private var isTransformationRunning: Bool
    
    /**
     Create a border node.
     */
    public init(gameStageStyle: GameStageStyle) {
        let sizes = Values.sharedValues.sizes
        
        self.gameStageStyle = gameStageStyle
        self.isTransformationRunning = false
        
        super.init(texture: nil, color: Colors.Background, size: CGSize(diameter: sizes.BorderDiameter))
        
        let thickness = sizes.BorderStrokeWidth
        borderArc = ArcNode(rotation: 0.0, degrees: 360.0, thickness: thickness, inRectWithDiameter: size.width)
        
        // The change in appearance is done with an overlay, which is moved
        // depending on the gameStageStyle
        let overlayPosX = gameStageStyle == .Bonus ? -sizes.BorderDiameter : 0.0
        overlay = SKSpriteNode(color: Colors.Background, size: CGSize(diameter: sizes.BorderDiameter))
        overlay.position = CGPoint(x: overlayPosX, y: -sizes.BorderDiameter / 2.0)
        
        addChild(borderArc)
        addChild(overlay)
        
        zPosition = ZPositions.OvalBorder
    }
    
    /**
     Toggle the border appearance depending on the current GameStageStyle
     In case of
        - Normal: only the upper half of the circle is visible
        - Bonus: full circle is visible
     
     - parameter animated: whether the toggle should animated
     */
    private func toggleAppearance(animated animated: Bool = true) {
        guard !isTransformationRunning else { return }
        isTransformationRunning = true
        
        gameStageStyle = gameStageStyle == .Normal ? .Bonus : .Normal
        
        let duration = animated ? ActionDuration : 0.0
        overlay.runAction(SKAction.moveByX(size.width, y: 0.0, duration: duration)) {
            self.isTransformationRunning = false
            
            if self.gameStageStyle == .Bonus {
                self.overlay.position.x = -self.size.width
            }
        }
    }
    
    /**
     Set the GameStageStyle of the border node.
        - Normal: only the upper half of the circle is visible
        - Bonus: full circle is visible
     - parameter animated: whether the style change should be animated
     */
    public func setStyle(style: GameStageStyle, animated: Bool = true) {
        // only need to set the style if it's different from the current one
        if gameStageStyle != style {
            toggleAppearance(animated: animated)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) not implemented")
    }
    
}

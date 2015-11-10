//
//  PlaingBackgroundNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-09.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

/**
 Background node for the scene when it's in playing state.
 
 Can be toggled to be either a full circle, or a half circle, to match the game's current stage style.
 */
public class PlaingBackgroundNode: SKNode {
    
    private(set) public var gameStageStyle: GameStageStyle  // the border adjusts its appearance to this value
    private var overlayNode: SKCropNode!                    // overlay to change the border appearance
    
    private var isTransformationRunning: Bool
    
    /**
     Create a background node.
     
     The background consists of different layers,
     which are ordered in a certain order: (bottom-to-top)
        1. circle in the middle, matching the playing area in size
        2. half-circle overlay to visually restrict the playing area for the stage style 'normal'
        3. solid whole-screen border around the circle, colored like the background
        4. stroke around the circle
     
     These different layers are needed for the animated visual transition between the stage styles.
     */
    public init(gameStageStyle: GameStageStyle) {
        let sizes = Values.sharedValues.sizes
        let positions = Values.sharedValues.positions
        
        self.gameStageStyle = gameStageStyle
        self.isTransformationRunning = false
        
        super.init()

        // circle in the middle
        let circleNode = SKShapeNode(circleOfRadius: sizes.BorderDiameter / 2.0)
        circleNode.position = positions.ScreenMiddle
        circleNode.fillColor = Colors.Cannon

        // half-circle overlay
        let overlayRect = SKSpriteNode(color: Colors.Target, size: CGSize(diameter: sizes.BorderDiameter))
        let overlayMask =  SKSpriteNode(texture: SKTexture(image: StyleKit.imageOfCircleMask(diameter: sizes.BorderDiameter)))
        overlayNode = SKCropNode()
        overlayNode.addChild(overlayRect)
        overlayNode.maskNode = overlayMask
        let overlayPosX = positions.ScreenMiddle.x - (gameStageStyle == .Bonus ? sizes.BorderDiameter : 0.0)
        overlayNode.position = CGPoint(x: overlayPosX, y: positions.ScreenMiddle.y)
        
        // background around the circle
        let borderNode = SKSpriteNode(texture: SKTexture(image: StyleKit.imageOfOuterBackgroundMask()))
        borderNode.position = positions.ScreenMiddle
        
        // stroked circle
        let circleStrokeNode = ArcNode(rotation: 0.0, degrees: 360.0, thickness: sizes.BorderStrokeWidth, inRectWithDiameter: sizes.BorderDiameter)
        circleStrokeNode.position = positions.ScreenMiddle
        
        // it's important to set the right zPositions to each node
        circleNode.zPosition = ZPositions.BorderBG
        overlayNode.zPosition = ZPositions.BorderOverlay
        borderNode.zPosition = ZPositions.BorderOuterMask
        circleStrokeNode.zPosition = ZPositions.BorderStroke

//        addChild(circleNode)
        addChild(overlayNode)
        addChild(borderNode)
        addChild(circleStrokeNode)
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
        let overlayWidth = overlayNode.maskNode!.frame.width
        
        let duration = animated ? ActionDuration : 0.0
        overlayNode.runAction(SKAction.moveByX(overlayWidth, y: 0.0, duration: duration)) {
            self.isTransformationRunning = false
            
            if self.gameStageStyle == .Bonus {
                self.overlayNode.position.x = self.overlayNode.position.x - 2 * overlayWidth
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

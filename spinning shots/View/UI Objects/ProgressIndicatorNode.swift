//
//  ProgressIndicatorNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-11-08.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

/**
    Node to indicate the game stage progress to the next stage of style Bonus.
 */
public class ProgressIndicatorNode: SKSpriteNode {
    
    private(set) public var progressNodes: [SKSpriteNode]   // progress nodes
    private(set) public var progressMax: Int                // amount of progress nodes
    private(set) public var progressCurrent: Int            // current progress
    
    /**
    Create a ProgressIndicatorNode for a progress target.
    - parameter progressTarget: amount of progress steps
    */
    public init(progressTarget: Int) {
        self.progressMax = progressTarget
        self.progressCurrent = 0
        self.progressNodes = []
        super.init(texture: nil, color: Colors.Background, size: Values.sharedValues.sizes.PlayingProgressIndicator)
        
        let gap: CGFloat = 2.0
        let totalGaps = CGFloat(progressMax - 1) * gap
        let nodeWidth = (size.width - totalGaps) / CGFloat(progressMax)
        let startPosX = -size.width / 2.0 + nodeWidth / 2.0
        
        for i in 0..<progressMax {
            let node = SKSpriteNode(color: Colors.Cannon, size: CGSize(width: nodeWidth, height: size.height))
            let nodePosX: CGFloat = CGFloat(i) * nodeWidth + CGFloat(i) * gap
            node.position = CGPoint(x: startPosX + nodePosX, y: 0.0)
            node.xScale = 0.0
            addChild(node)
            progressNodes.append(node)
        }
    }
    
    /**
     Advance one step, making the next progress step node visible.
     - parameter aniamated: whether the advancing should be animated
     */
    public func advanceProgress(animated animated: Bool = true) {
        let duration = animated ? ActionDuration : 0.0
        
        let node = progressNodes[progressCurrent]
        node.runAction(SKAction.scaleXTo(1.0, duration: duration))
        
        self.progressCurrent++
    }
    
    /**
     Reset the progress.
     - parameter aniamated: whether the reset should be animated
     */
    public func resetProgress(animated animated: Bool = true) {
        let duration = animated ? ActionDuration : 0.0
        
        for node in progressNodes {
            node.runAction(SKAction.scaleXTo(0.0, duration: duration))
        }
        progressCurrent = 0
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

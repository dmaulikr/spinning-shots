//
//  PlayingNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

public class PlayingNode: SKNode {
    private var sceneDelegate: SceneDelegate
    private var scoreLabel: Label!
    
    private var isTransitionRunning = false
    
    private let sizes = Values.sharedValues.sizes
    
    public init(sceneDelegate: SceneDelegate) {
        self.sceneDelegate = sceneDelegate
        
        super.init()
        zPosition = ZPositions.UINode
        
        setupUI()
        
        InstanceCountingInitInstance(self)
    }
    
    private func setupUI() {
        scoreLabel = Label(text: "0", fontSize: sizes.PlayingScoreLabelSize)
        scoreLabel.name = "scoreLabel"
        let scoreLabelPosY = sizes.Screen.height - scoreLabel.frame.height / 2.0 - 32.0
        scoreLabel.position = CGPoint(x: sizes.Screen.middle.x, y: scoreLabelPosY)
        scoreLabel.horizontalAlignmentMode = .Center
        scoreLabel.verticalAlignmentMode = .Center
        scoreLabel.alpha = 0.0
        scoreLabel.setScale(0.0)
        addChild(scoreLabel)
        
        let fadeIn = SKAction.fadeInWithDuration(ActionDuration)
        let scaleup = SKAction.scaleTo(1.0, duration: ActionDuration)
        let fadeInAndScaleUp = SKAction.group([fadeIn, scaleup])
        scoreLabel.runAction(fadeInAndScaleUp)
    }
    
    public func updateScoreLabel(withScore score: Int) {
        scoreLabel.text = "\(score)"
    }
    
    public func close(withTargetState targetState: SceneState) {
        isTransitionRunning = true
        
        let fadeOut = SKAction.fadeOutWithDuration(ActionDuration)
        let fadeOutAndPop = SKAction.group([fadeOut, SKAction.popAction])
        
        let groupAction = SKAction.group([
            SKAction.runAction(SKAction.group([fadeOutAndPop]), onChildWithName: scoreLabel.name!)
            ])
        
        let sequenceAction = SKAction.sequence([
            SKAction.waitForDuration(ActionDuration),
            groupAction
            ])
        
        startClosingTransition(withAction: sequenceAction, targetState: targetState)
    }
    
    private func startClosingTransition(withAction action: SKAction, targetState: SceneState) {
        let wait = SKAction.waitForDuration(ActionDuration)
        let block = SKAction.runBlock {
            self.sceneDelegate.completedTransitionFromState(.Playing, andShouldNowSwitchToState: targetState)
        }
        runAction(SKAction.sequence([action, wait, block]))
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard !isTransitionRunning else { return }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
}
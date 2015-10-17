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
    private var bulletsLabel: Label!
    
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
        scoreLabel = Label(text: "Score: 0", fontSize: 24.0)
        scoreLabel.name = "scoreLabel"
        scoreLabel.position = CGPoint(x: sizes.Screen.middle.x, y: sizes.Screen.height * 0.9)
        scoreLabel.horizontalAlignmentMode = .Center
        scoreLabel.verticalAlignmentMode = .Center
        scoreLabel.alpha = 0.0
        addChild(scoreLabel)
        
        bulletsLabel = Label(text: "Bullets: 1", fontSize: 24.0)
        bulletsLabel.name = "bulletsLabel"
        bulletsLabel.position = CGPoint(x: sizes.Screen.middle.x, y: sizes.Screen.height * 0.85)
        bulletsLabel.horizontalAlignmentMode = .Center
        bulletsLabel.verticalAlignmentMode = .Center
        bulletsLabel.alpha = 0.0
        addChild(bulletsLabel)
        
        let fadeIn = SKAction.fadeInWithDuration(ActionDuration)
        scoreLabel.runAction(fadeIn)
        bulletsLabel.runAction(fadeIn)
    }
    
    public func updateScoreLabel(withScore score: Int) {
        scoreLabel.text = "Score: \(score)"
    }
    
    public func updateBulletsLabel(withBullets bullets: Int) {
        bulletsLabel.text = "Bullets: \(bullets)"
    }
    
    public func close(withTargetState targetState: SceneState) {
        isTransitionRunning = true
        
        let fadeOut = SKAction.fadeOutWithDuration(ActionDuration)
        let fadeOutAndPop = SKAction.group([fadeOut, SKAction.popAction])
        
        let groupAction = SKAction.group([
            SKAction.runAction(SKAction.group([fadeOutAndPop]), onChildWithName: scoreLabel.name!),
            SKAction.runAction(SKAction.group([fadeOutAndPop]), onChildWithName: bulletsLabel.name!)
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
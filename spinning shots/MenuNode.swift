//
//  MenuNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

public class MenuNode: SKNode {
    
    private var sceneDelegate: SceneDelegate
    private var playButton: Button!
    
    
    private var isTransitionRunning = false
    
    public init(sceneDelegate: SceneDelegate) {
        self.sceneDelegate = sceneDelegate
        
        super.init()
        zPosition = ZPositions.UINode
        
        setupUI()
        
        InstanceCountingInitInstance(self)
    }
    
    private func setupUI() {
        playButton = Button(item: .Play)
        playButton.name = "playButton"
        playButton.position = Values.sharedValues.sizes.Screen.middle
        playButton.alpha = 0.0
        playButton.setScale(0.0)
        addChild(playButton)
        
        let fadeIn = SKAction.fadeInWithDuration(ActionDuration)
        let scaleUp = SKAction.scaleTo(1.0, duration: ActionDuration)
        let fadeInAndScaleUp = SKAction.group([fadeIn, scaleUp])
        playButton.runAction(fadeInAndScaleUp)
    }
    
    public func close(withTargetState targetState: SceneState) {
        isTransitionRunning = true
        
        let fadeOut = SKAction.fadeOutWithDuration(ActionDuration)
        let fadeOutAndPop = SKAction.group([fadeOut, SKAction.popAction])
        
        let groupAction = SKAction.group([
            SKAction.runAction(SKAction.group([fadeOutAndPop]), onChildWithName: playButton.name!)
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
            self.sceneDelegate.completedTransitionFromState(.Menu, andShouldNowSwitchToState: targetState)
        }
        runAction(SKAction.sequence([action, wait, block]))
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard !isTransitionRunning else { return }
        
        let location = touches.first!.locationInNode(self)
        
        if CGRectContainsPoint(playButton.frame, location) {
            close(withTargetState: .Playing)
        } else {
            InstanceCountingDumpInstances()
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)not implemented")
    }
    
}

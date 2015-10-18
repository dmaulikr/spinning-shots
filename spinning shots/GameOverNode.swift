//
//  GameOverNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

public class GameOverNode: SKNode {
    private var sceneDelegate: SceneDelegate
    private var score: Int
    
    private var homeButton: Button!
    private var shareButton: Button!
    private var gamecenterButton: Button!
    
    private var isTransitionRunning = false
    
    public init(sceneDelegate: SceneDelegate, score: Int) {
        self.sceneDelegate = sceneDelegate
        self.score = score
        
        super.init()
        zPosition = ZPositions.UINode
        
        setupUI()
        
        InstanceCountingInitInstance(self)
    }
    
    private func setupUI() {
        let positions = Values.sharedValues.positions
        
        homeButton = Button(item: .Home)
        homeButton.name = "homeButton"
        homeButton.position = positions.GameOverHomeButton
        homeButton.alpha = 0.0
        homeButton.setScale(0.0)
        addChild(homeButton)
        
        shareButton = Button(item: .Share)
        shareButton.name = "shareButton"
        shareButton.position = positions.GameOverShareButton
        shareButton.alpha = 0.0
        shareButton.setScale(0.0)
        addChild(shareButton)
        
        gamecenterButton = Button(item: .GameCenter)
        gamecenterButton.name = "gamecenterButton"
        gamecenterButton.position = positions.GameOverGameCenterButton
        gamecenterButton.alpha = 0.0
        gamecenterButton.setScale(0.0)
        addChild(gamecenterButton)

        homeButton.runAction(SKAction.fadeInAndScaleUp(ActionDuration))
        shareButton.runAction(SKAction.fadeInAndScaleUp(ActionDuration))
        gamecenterButton.runAction(SKAction.fadeInAndScaleUp(ActionDuration))
    }
    
    public func close(withTargetState targetState: SceneState) {
        isTransitionRunning = true
        
        let fadeOut = SKAction.fadeOutWithDuration(ActionDuration)
        let fadeOutAndPop = SKAction.group([fadeOut, SKAction.popAction])
        
        let groupAction = SKAction.group([
            SKAction.runAction(SKAction.group([fadeOutAndPop]), onChildWithName: homeButton.name!),
            SKAction.runAction(SKAction.group([fadeOutAndPop]), onChildWithName: shareButton.name!),
            SKAction.runAction(SKAction.group([fadeOutAndPop]), onChildWithName: gamecenterButton.name!)
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
            self.sceneDelegate.completedTransitionFromState(.GameOver, andShouldNowSwitchToState: targetState)
        }
        runAction(SKAction.sequence([action, wait, block]))
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard !isTransitionRunning else { return }
        
        let location = touches.first!.locationInNode(self)
        
        if CGRectContainsPoint(homeButton.frame, location) {
            close(withTargetState: .Menu)
        } else if CGRectContainsPoint(shareButton.frame, location) {
            print("share")
        } else if CGRectContainsPoint(gamecenterButton.frame, location) {
            print("gameCenter")
        } else {
            InstanceCountingDumpInstances()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
}
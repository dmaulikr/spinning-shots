//
//  MenuNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

/**
 Node containing the UI elements for the menu scene state.
 */
public class MenuNode: SKNode {
    
    private var sceneDelegate: SceneTransitionDelegate      // delegate used to inform the scene about transitions
    
    private var playButton: ButtonNode!                     // button for switching to the playing state
    
    private var isTransitionRunning = false                 // indicates whether the closing transition is running
    
    /**
    Create a menu node.
    - parameter sceneDelegate: delegate to be informed about transitions
    */
    public init(sceneDelegate: SceneTransitionDelegate) {
        self.sceneDelegate = sceneDelegate
        
        super.init()
        zPosition = ZPositions.UINode
        
        setupUI()
    }
    
    /**
     Set up the UI.
     
     This method first creates the elements and then animates them in.
     */
    private func setupUI() {
        // add the UI elements
        playButton = ButtonNode(item: .Play)
        playButton.name = "playButton"
        playButton.position = Values.sharedValues.sizes.Screen.middle
        playButton.alpha = 0.0
        playButton.setScale(0.0)
        addChild(playButton)
        
        // animate the elements in with a fade and scale action
        let fadeIn = SKAction.fadeInWithDuration(ActionDuration)
        let scaleUp = SKAction.scaleTo(1.0, duration: ActionDuration)
        let fadeInAndScaleUp = SKAction.group([fadeIn, scaleUp])
        playButton.runAction(fadeInAndScaleUp)
    }
    
    /**
     Close this UI node and transition to another state.
     - parameter targetState: state the scene shoul transition to
     */
    public func close(withTargetState targetState: SceneState) {
        isTransitionRunning = true
        
        // create animation actions
        let fadeOut = SKAction.fadeOutWithDuration(ActionDuration)
        let fadeOutAndPop = SKAction.group([fadeOut, SKAction.popAction])
        let groupAction = SKAction.group([
            SKAction.runAction(SKAction.group([fadeOutAndPop]), onChildWithName: playButton.name!)
            ])
        
        // chain animations
        let sequenceAction = SKAction.sequence([
            SKAction.waitForDuration(ActionDuration),
            groupAction
            ])
        
        // start transition with animations
        startClosingTransition(withAction: sequenceAction, targetState: targetState)
    }
    
    /**
     Perform the closing animations and inform the delegate about the completion of the transition.
     - parameter action: animation action to be performed
     - parameter targetState: state to transition to
     */
    private func startClosingTransition(withAction action: SKAction, targetState: SceneState) {
        let wait = SKAction.waitForDuration(ActionDuration)
        let block = SKAction.runBlock {
            self.sceneDelegate.completedTransitionFromState(.Menu, andShouldNowSwitchToState: targetState)
        }
        runAction(SKAction.sequence([action, wait, block]))
    }
    
    /**
     Process touches on this UI node.
     */
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // only process touches if not currently transitioning to another state.
        guard !isTransitionRunning else { return }
        
        let location = touches.first!.locationInNode(self)
        
        // check whether an UI element was touched
        if CGRectContainsPoint(playButton.frame, location) {
            // play button was touched
            // -> close this node and switch to playing state
            close(withTargetState: .Playing)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)not implemented")
    }
    
}

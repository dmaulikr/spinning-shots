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
    private var tmpLabel: Label!
    
    private var isTransitionRunning = false
    
    public init(sceneDelegate: SceneDelegate) {
        self.sceneDelegate = sceneDelegate
        
        super.init()
        zPosition = ZPositions.UINode
        
        setupUI()
    }
    
    private func setupUI() {
        tmpLabel = Label(text: "Menu", fontSize: 24.0)
        tmpLabel.name = "tmpLabel"
        tmpLabel.position = Values.sharedValues.sizes.Screen.middle
        tmpLabel.horizontalAlignmentMode = .Center
        tmpLabel.verticalAlignmentMode = .Center
        tmpLabel.alpha = 0.0
        addChild(tmpLabel)
        
        let fadeIn = SKAction.fadeInWithDuration(ActionDuration)
        tmpLabel.runAction(fadeIn)
    }
    
    public func close(withTargetState targetState: SceneState) {
        isTransitionRunning = true
        
        let fadeOut = SKAction.fadeOutWithDuration(ActionDuration)
        let fadeOutAndPop = SKAction.group([fadeOut, SKAction.popAction])
        
        let groupAction = SKAction.group([
            SKAction.runAction(SKAction.group([fadeOutAndPop]), onChildWithName: tmpLabel.name!)
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
        
        close(withTargetState: .Playing)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)not implemented")
    }
    
}

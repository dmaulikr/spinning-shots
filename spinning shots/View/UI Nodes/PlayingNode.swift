//
//  PlayingNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

/**
 Node containing the UI elements for the playing scene state.
 */
public class PlayingNode: SKNode {
    private var sceneDelegate: SceneTransitionDelegate  // delegate used to inform the scene about transitions
    
    private var backgroundNode: PlaingBackgroundNode!   // indicating the playing area & stage style
    private var scoreLabel: LabelNode!                  // label displaying the current score
    private(set) public var  progressIndicator: ProgressIndicatorNode! // showing the game stage progress
    
    private var isTransitionRunning = false             // indicates whether the closing transition is
    
    private let sizes = Values.sharedValues.sizes
    
    /**
     Create a playing node.
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
        // Add the UI elements
        backgroundNode = PlaingBackgroundNode(gameStageStyle: .Normal)
        backgroundNode.name = "backgroundNode"
        backgroundNode.prepareForAnimateIn()
        addChild(backgroundNode)
        
        scoreLabel = LabelNode(text: "0", fontSize: sizes.PlayingScoreLabelSize)
        scoreLabel.name = "scoreLabel"
        let scoreLabelPosY = sizes.Screen.height - scoreLabel.frame.height / 2.0 - 32.0
        scoreLabel.position = CGPoint(x: sizes.Screen.middle.x, y: scoreLabelPosY)
        scoreLabel.horizontalAlignmentMode = .Center
        scoreLabel.verticalAlignmentMode = .Center
        scoreLabel.alpha = 0.0
        scoreLabel.setScale(0.0)
        addChild(scoreLabel)
        
        progressIndicator = ProgressIndicatorNode(progressTarget: 5)
        progressIndicator.name = "progressIndicator"
        let progressIndicatorPosY = sizes.Screen.height <= 500.00 ? sizes.PlayingScoreLabelSize / 2.0 - 8.0 : scoreLabel.frame.origin.y - sizes.PlayingScoreLabelSize / 2.0 - 8.0
        progressIndicator.position = CGPoint(x: sizes.Screen.middle.x, y: progressIndicatorPosY)
        progressIndicator.alpha = 0.0
        progressIndicator.setScale(0.0)
        addChild(progressIndicator)
        
        // animate the elements in with a fade and scale action
        let fadeIn = SKAction.fadeInWithDuration(ActionDuration)
        let scaleup = SKAction.scaleTo(1.0, duration: ActionDuration)
        let fadeInAndScaleUp = SKAction.group([fadeIn, scaleup])
        scoreLabel.runAction(fadeInAndScaleUp)
        progressIndicator.runAction(fadeInAndScaleUp)
        
        backgroundNode.fadeIn()
    }
    
    /**
     Update the playing-background to match the game's stage style.
     - parameter style: stage style
     */
    public func updatePlayingBackground(forStyle style: GameStageStyle) {
        backgroundNode.setStyle(style)
    }
    
    /**
     Update the label text.
     - parameter score: score to display
     */
    public func updateScoreLabel(withScore score: Int) {
        scoreLabel.text = "\(score)"
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
            SKAction.runAction(fadeOutAndPop, onChildWithName: scoreLabel.name!),
            SKAction.runAction(fadeOut, onChildWithName: progressIndicator.name!)
            ])
        
        // chain animations
        let sequenceAction = SKAction.sequence([
            SKAction.waitForDuration(ActionDuration), // wait for the wiggle animation to finish (performed in the scene)
            groupAction,
            SKAction.runBlock { self.backgroundNode.fadeOut() }
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
            self.sceneDelegate.completedTransitionFromState(.Playing, andShouldNowSwitchToState: targetState)
        }
        runAction(SKAction.sequence([action, wait, block]))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
}
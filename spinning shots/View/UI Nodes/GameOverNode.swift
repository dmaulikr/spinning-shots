//
//  GameOverNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

/**
 Node containing the UI elements for the game over scene state.
 */
public class GameOverNode: SKNode {
    private var sceneDelegate: SceneTransitionDelegate  // delegate used to inform the scene about transitions
    
    private var score: Int                              // the game's end score
    private var bestScore: Int                          // the users's best score
    
    private var titleLabel: LabelNode!                  // label displaying the game over title
    private var scoreLabel: LabelNode!                  // label displaying the score
    private var scoreTitleLabel: LabelNode!             // label displaying the score title
    private var bestScoreLabel: LabelNode!              // label displaying the best score
    private var bestScoreTitleLabel: LabelNode!         // label displaying the best score title
    
    private var homeButton: ButtonNode!                 // button for switching to the menu state
    private var shareButton: ButtonNode!                // button for sharing the score
    private var gamecenterButton: ButtonNode!           // button for launching game center
    
    private var isTransitionRunning = false             // indicates whether the closing transition is running
    
    private let sizes = Values.sharedValues.sizes
    private let positions = Values.sharedValues.positions
    
    /**
     Create a game over node.
     - parameter sceneDelegate: delegate to be informed about transitions
     */
    public init(sceneDelegate: SceneTransitionDelegate, score: Int) {
        self.sceneDelegate = sceneDelegate
        self.score = score
        self.bestScore = Settings.sharedManager.bestScore
        
        super.init()
        zPosition = ZPositions.UINode
        
        setupUI()
    }
    
    /**
     Set up the UI.
     
     This method first creates the elements and then animates them in.
     */
    private func setupUI() {
        let titleFontSize = sizes.Screen.height * 0.075
        
        // add the UI elements
        titleLabel = LabelNode(text: "Game Over", fontSize: titleFontSize)
        titleLabel.name = "titleLabel"
        titleLabel.fontColor = Colors.Target
        let titleLabelPosY = sizes.Screen.height - titleLabel.frame.height / 2.0 - 32.0
        titleLabel.position = CGPoint(x: sizes.Screen.middle.x, y: titleLabelPosY)
        titleLabel.horizontalAlignmentMode = .Center
        titleLabel.verticalAlignmentMode = .Center
        titleLabel.alpha = 0.0
        titleLabel.setScale(0.0)
        addChild(titleLabel)
        
        let scoreLabelPosAfterTransition = positions.ScreenMiddle
        let scoreLabelPosBeforeTransition = CGPoint(x: scoreLabelPosAfterTransition.x - sizes.Screen.width, y: scoreLabelPosAfterTransition.y)
        scoreLabel = LabelNode(text: "\(score)", fontSize: titleFontSize * 1.5)
        scoreLabel.name = "scoreLabel"
        scoreLabel.fontColor = Colors.Target
        scoreLabel.position = scoreLabelPosBeforeTransition
        scoreLabel.horizontalAlignmentMode = .Center
        scoreLabel.verticalAlignmentMode = .Bottom
        addChild(scoreLabel)
        
        let scoreTitleLabelPosAfterTransition = CGPoint(x: scoreLabelPosAfterTransition.x, y: scoreLabelPosAfterTransition.y + scoreLabel.frame.height + 2.0)
        let scoreTitleLabelPosBeforeTransition = CGPoint(x: scoreTitleLabelPosAfterTransition.x - sizes.Screen.width, y: scoreTitleLabelPosAfterTransition.y)
        scoreTitleLabel = LabelNode(text: "SCORE", fontSize: titleFontSize * 0.75)
        scoreTitleLabel.name = "scoreTitleLabel"
        scoreTitleLabel.fontColor = Colors.Target
        scoreTitleLabel.position = scoreTitleLabelPosBeforeTransition
        scoreTitleLabel.horizontalAlignmentMode = .Center
        scoreTitleLabel.verticalAlignmentMode = .Bottom
        addChild(scoreTitleLabel)
        
        let bestScoreTitleLabelPosAfterTransition = CGPoint(x: scoreLabelPosAfterTransition.x, y: scoreLabelPosAfterTransition.y - 2.0)
        let bestScoreTitleLabelPosBeforeTransition = CGPoint(x: bestScoreTitleLabelPosAfterTransition.x + sizes.Screen.width, y: bestScoreTitleLabelPosAfterTransition.y)
        bestScoreTitleLabel = LabelNode(text: "BEST", fontSize: titleFontSize * 0.45)
        bestScoreTitleLabel.name = "bestScoreTitleLabel"
        bestScoreTitleLabel.fontColor = Colors.Target
        bestScoreTitleLabel.position = bestScoreTitleLabelPosBeforeTransition
        bestScoreTitleLabel.horizontalAlignmentMode = .Center
        bestScoreTitleLabel.verticalAlignmentMode = .Top
        addChild(bestScoreTitleLabel)
        
        let bestScoreLabelPosAfterTransition = CGPoint(x: bestScoreTitleLabelPosAfterTransition.x, y: bestScoreTitleLabelPosAfterTransition.y - bestScoreTitleLabel.frame.height - 2.0)
        let bestScoreLabelPosBeforeTransition = CGPoint(x: bestScoreLabelPosAfterTransition.x + sizes.Screen.width, y: bestScoreLabelPosAfterTransition.y)
        bestScoreLabel = LabelNode(text: "\(bestScore)", fontSize: titleFontSize * 0.95)
        bestScoreLabel.name = "bestScoreLabel"
        bestScoreLabel.fontColor = Colors.Target
        bestScoreLabel.position = bestScoreLabelPosBeforeTransition
        bestScoreLabel.horizontalAlignmentMode = .Center
        bestScoreLabel.verticalAlignmentMode = .Top
        addChild(bestScoreLabel)
        
        homeButton = ButtonNode(item: .Home)
        homeButton.name = "homeButton"
        homeButton.position = positions.GameOverHomeButton
        homeButton.alpha = 0.0
        homeButton.setScale(0.0)
        addChild(homeButton)
        
        shareButton = ButtonNode(item: .Share)
        shareButton.name = "shareButton"
        shareButton.position = positions.GameOverShareButton
        shareButton.alpha = 0.0
        shareButton.setScale(0.0)
        addChild(shareButton)
        
        gamecenterButton = ButtonNode(item: .GameCenter)
        gamecenterButton.name = "gamecenterButton"
        gamecenterButton.position = positions.GameOverGameCenterButton
        gamecenterButton.alpha = 0.0
        gamecenterButton.setScale(0.0)
        addChild(gamecenterButton)
        
        // animate the elements in
        let moveScore = SKAction.moveTo(scoreLabelPosAfterTransition, duration: ActionDuration)
        let moveScoreTitle = SKAction.moveTo(scoreTitleLabelPosAfterTransition, duration: ActionDuration)
        let moveBestScore = SKAction.moveTo(bestScoreLabelPosAfterTransition, duration: ActionDuration)
        let moveBestScoreTitle = SKAction.moveTo(bestScoreTitleLabelPosAfterTransition, duration: ActionDuration)
        scoreLabel.runAction(moveScore)
        scoreTitleLabel.runAction(moveScoreTitle)
        bestScoreLabel.runAction(moveBestScore)
        bestScoreTitleLabel.runAction(moveBestScoreTitle)
        
        titleLabel.runAction(SKAction.fadeInAndScaleUp(ActionDuration))
        homeButton.runAction(SKAction.fadeInAndScaleUp(ActionDuration))
        shareButton.runAction(SKAction.fadeInAndScaleUp(ActionDuration))
        gamecenterButton.runAction(SKAction.fadeInAndScaleUp(ActionDuration))
    }
    
    /**
     Close this UI node and transition to another state.
     - parameter targetState: state the scene shoul transition to
     */
    public func close(withTargetState targetState: SceneState) {
        isTransitionRunning = true
        
        // This is a 2-step animation/transition
        // 1. fade/scale out the title and buttons
        // -> when 1. is finished:
        // 2. move score labels out of screen bounds
        
        // create and run fade+scale animation actions
        let fadeOut = SKAction.fadeOutWithDuration(ActionDuration)
        let fadeOutAndPop = SKAction.group([fadeOut, SKAction.popAction])
        
        titleLabel.runAction(fadeOutAndPop)
        homeButton.runAction(fadeOutAndPop)
        shareButton.runAction(fadeOutAndPop)
        gamecenterButton.runAction(fadeOutAndPop)
        
        // create label-move animation actions
        let moveToRight = SKAction.moveByX(sizes.Screen.width, y: 0.0, duration: ActionDuration)
        let moveToLeft = SKAction.moveByX(-sizes.Screen.width, y: 0.0, duration: ActionDuration)
        let groupAction = SKAction.group([
            SKAction.runAction(moveToRight, onChildWithName: scoreLabel.name!),
            SKAction.runAction(moveToRight, onChildWithName: scoreTitleLabel.name!),
            SKAction.runAction(moveToLeft, onChildWithName: bestScoreLabel.name!),
            SKAction.runAction(moveToLeft, onChildWithName: bestScoreTitleLabel.name!)
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
            self.sceneDelegate.completedTransitionFromState(.GameOver, andShouldNowSwitchToState: targetState)
        }
        runAction(SKAction.sequence([action, wait, block]))
    }
    
    /**
     Send a notification to share the score.
     
     The listener for this notification should be added to the main ViewController.
     
     - parameter touchLocationString: string representation of the touched location
     */
    private func shareScore(touchLocationString: String) {
        let buttonSize = NSStringFromCGSize(shareButton.frame.size)
        let info = ["Score" : score, "TouchLocation" : touchLocationString, "ButtonSize" : buttonSize]
        NSNotificationCenter.defaultCenter().postNotificationName("ShareScore", object: self, userInfo: info as [NSObject : AnyObject])
    }
    
    /**
     Process touches on this UI node.
     */
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // only process touches if not currently transitioning to another state.
        guard !isTransitionRunning else { return }
        
        let location = touches.first!.locationInNode(self)
        
        // check whether an UI element was touched
        if CGRectContainsPoint(homeButton.frame, location) {
            // home button was touched
            // -> close this node and switch to menu state
            close(withTargetState: .Menu)
        } else if CGRectContainsPoint(shareButton.frame, location) {
            // share button was touched
            // -> share score
            shareButton.runAction(SKAction.tapAction)
            shareScore(NSStringFromCGPoint(location))
        } else if CGRectContainsPoint(gamecenterButton.frame, location) {
            // gamecenter button was touched
            // -> open game center
            gamecenterButton.runAction(SKAction.tapAction)
            GameCenterManager.sharedManager.showLeaderboards()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
}
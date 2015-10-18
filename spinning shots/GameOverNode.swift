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
    private var bestScore: Int
    
    private var titleLabel: Label!
    private var scoreLabel: Label!
    private var scoreTitleLabel: Label!
    private var bestScoreLabel: Label!
    private var bestScoreTitleLabel: Label!
    
    private var homeButton: Button!
    private var shareButton: Button!
    private var gamecenterButton: Button!
    
    private var isTransitionRunning = false
    
    private let sizes = Values.sharedValues.sizes
    private let positions = Values.sharedValues.positions
    
    public init(sceneDelegate: SceneDelegate, score: Int) {
        self.sceneDelegate = sceneDelegate
        self.score = score
        self.bestScore = Settings.sharedManager.bestScore
        
        super.init()
        zPosition = ZPositions.UINode
        
        setupUI()
        
        InstanceCountingInitInstance(self)
    }
    
    private func setupUI() {
        let titleFontSize = sizes.Screen.height * 0.075
        
        titleLabel = Label(text: "Game Over", fontSize: titleFontSize)
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
        scoreLabel = Label(text: "\(score)", fontSize: titleFontSize * 1.5)
        scoreLabel.name = "scoreLabel"
        scoreLabel.fontColor = Colors.Target
        scoreLabel.position = scoreLabelPosBeforeTransition
        scoreLabel.horizontalAlignmentMode = .Center
        scoreLabel.verticalAlignmentMode = .Bottom
        addChild(scoreLabel)
        
        let scoreTitleLabelPosAfterTransition = CGPoint(x: scoreLabelPosAfterTransition.x, y: scoreLabelPosAfterTransition.y + scoreLabel.frame.height + 2.0)
        let scoreTitleLabelPosBeforeTransition = CGPoint(x: scoreTitleLabelPosAfterTransition.x - sizes.Screen.width, y: scoreTitleLabelPosAfterTransition.y)
        scoreTitleLabel = Label(text: "SCORE", fontSize: titleFontSize * 0.75)
        scoreTitleLabel.name = "scoreTitleLabel"
        scoreTitleLabel.fontColor = Colors.Target
        scoreTitleLabel.position = scoreTitleLabelPosBeforeTransition
        scoreTitleLabel.horizontalAlignmentMode = .Center
        scoreTitleLabel.verticalAlignmentMode = .Bottom
        addChild(scoreTitleLabel)
        
        let bestScoreTitleLabelPosAfterTransition = CGPoint(x: scoreLabelPosAfterTransition.x, y: scoreLabelPosAfterTransition.y - 2.0)
        let bestScoreTitleLabelPosBeforeTransition = CGPoint(x: bestScoreTitleLabelPosAfterTransition.x + sizes.Screen.width, y: bestScoreTitleLabelPosAfterTransition.y)
        bestScoreTitleLabel = Label(text: "BEST", fontSize: titleFontSize * 0.45)
        bestScoreTitleLabel.name = "bestScoreTitleLabel"
        bestScoreTitleLabel.fontColor = Colors.Target
        bestScoreTitleLabel.position = bestScoreTitleLabelPosBeforeTransition
        bestScoreTitleLabel.horizontalAlignmentMode = .Center
        bestScoreTitleLabel.verticalAlignmentMode = .Top
        addChild(bestScoreTitleLabel)
        
        let bestScoreLabelPosAfterTransition = CGPoint(x: bestScoreTitleLabelPosAfterTransition.x, y: bestScoreTitleLabelPosAfterTransition.y - bestScoreTitleLabel.frame.height - 2.0)
        let bestScoreLabelPosBeforeTransition = CGPoint(x: bestScoreLabelPosAfterTransition.x + sizes.Screen.width, y: bestScoreLabelPosAfterTransition.y)
        bestScoreLabel = Label(text: "\(bestScore)", fontSize: titleFontSize * 0.95)
        bestScoreLabel.name = "bestScoreLabel"
        bestScoreLabel.fontColor = Colors.Target
        bestScoreLabel.position = bestScoreLabelPosBeforeTransition
        bestScoreLabel.horizontalAlignmentMode = .Center
        bestScoreLabel.verticalAlignmentMode = .Top
        addChild(bestScoreLabel)
        
        
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
    
    public func close(withTargetState targetState: SceneState) {
        isTransitionRunning = true
        
        let fadeOut = SKAction.fadeOutWithDuration(ActionDuration)
        let fadeOutAndPop = SKAction.group([fadeOut, SKAction.popAction])
        
        titleLabel.runAction(fadeOutAndPop)
        homeButton.runAction(fadeOutAndPop)
        shareButton.runAction(fadeOutAndPop)
        gamecenterButton.runAction(fadeOutAndPop)
        
        let moveToRight = SKAction.moveByX(sizes.Screen.width, y: 0.0, duration: ActionDuration)
        let moveToLeft = SKAction.moveByX(-sizes.Screen.width, y: 0.0, duration: ActionDuration)
        let groupAction = SKAction.group([
            SKAction.runAction(moveToRight, onChildWithName: scoreLabel.name!),
            SKAction.runAction(moveToRight, onChildWithName: scoreTitleLabel.name!),
            SKAction.runAction(moveToLeft, onChildWithName: bestScoreLabel.name!),
            SKAction.runAction(moveToLeft, onChildWithName: bestScoreTitleLabel.name!)
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
    
    private func shareScore(touchLocationString: String) {
        let buttonSize = NSStringFromCGSize(shareButton.frame.size)
        let info = ["Score" : score, "TouchLocation" : touchLocationString, "ButtonSize" : buttonSize]
        NSNotificationCenter.defaultCenter().postNotificationName("ShareScore", object: self, userInfo: info as [NSObject : AnyObject])
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard !isTransitionRunning else { return }
        
        let location = touches.first!.locationInNode(self)
        
        if CGRectContainsPoint(homeButton.frame, location) {
            close(withTargetState: .Menu)
        } else if CGRectContainsPoint(shareButton.frame, location) {
            shareButton.runAction(SKAction.tapAction)
            shareScore(NSStringFromCGPoint(location))
        } else if CGRectContainsPoint(gamecenterButton.frame, location) {
            gamecenterButton.runAction(SKAction.tapAction)
            GameCenterManager.sharedManager.showLeaderboards()
        } else {
            InstanceCountingDumpInstances()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
}
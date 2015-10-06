//
//  Scene.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

public protocol SceneDelegate {
    func completedTransitionFromState(fromState: SceneState, andShouldNowSwitchToState toState: SceneState)
}

public enum SceneState: Int {
    case Menu, Playing, GameOver
}

public class Scene: SKScene, GameDelegate {
    
    private var menuNode: MenuNode?
    private var playingNode: PlayingNode?
    private var gameOverNode: GameOverNode?
    
    private var sceneState: SceneState!
    private var game: Game!

    private var isGameRunning = false
    private var lastUpdateTime: NSTimeInterval = 0.0
    private var dt: NSTimeInterval = 0.0
    
    private var backgroundNode: BackgroundNode!
    
    private let sizes = Values.sharedValues.sizes
    
    public override func didMoveToView(view: SKView) {
        game = Game()
        game.gameDelegate = self
        
        initBackgroundNode()
        
        switchToState(.Menu)
    }
    
    public func gameDidStart() {
        isGameRunning = true
    }
    
    public func gameDidEnd(score: Int) {
        isGameRunning = false
        
        // remove entities etc from ui
        saveScore(score)
        
        playingNode?.close(withTargetState: .GameOver)
    }
    
    public func gameDidScore(newScore: Int) {
        // forward score to playingnode
    }
    
    private func initBackgroundNode() {
        backgroundNode = BackgroundNode()
        backgroundNode.position = size.middle
        addChild(backgroundNode)
    }
    
    public func startNewGame() {
        // init ui stuff
        
        game.startNewGame()
    }
    
    public override func update(currentTime: NSTimeInterval) {
        super.update(currentTime)
        
        dt =  lastUpdateTime > 0 ? currentTime - lastUpdateTime : 0.0
        if dt > 1.0/30.0 {
            dt = 1.0/30.0
        }
        
        lastUpdateTime = currentTime
        
        guard isGameRunning else { return }
        
        game.tick(dt)
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        switch sceneState as SceneState {
        case .Menu: menuNode?.touchesBegan(touches, withEvent: event)
        case .Playing: playingNode?.touchesBegan(touches, withEvent: event)
        case .GameOver: gameOverNode?.touchesBegan(touches, withEvent: event)
        }
    }
    
    private func switchToState(state: SceneState) {
        func switchToMenuState() {
            sceneState = .Menu
            
            menuNode = MenuNode(sceneDelegate: self)
            addChild(menuNode!)
        }
        
        func switchToPlayingState() {
            sceneState = .Playing
            
            playingNode = PlayingNode(sceneDelegate: self)
            addChild(playingNode!)
            
            startNewGame()
        }
        
        func switchToGameOverState() {
            sceneState = .GameOver
            
            gameOverNode = GameOverNode(sceneDelegate: self, score: game.score)
            addChild(gameOverNode!)
        }
        
        switch state {
        case .Menu: switchToMenuState()
        case .Playing: switchToPlayingState()
        case .GameOver: switchToGameOverState()
        }
    }
    
    private func saveScore(score: Int) {
        let bestScore = Settings.sharedManager.bestScore
        if score > bestScore {
            //GameCenterManager.sharedManager.reportScore(score) // TODO: activate
            Settings.sharedManager.setBestScore(score)
        }
    }
    
}

extension Scene: SceneDelegate {
    public func completedTransitionFromState(fromState: SceneState, andShouldNowSwitchToState toState: SceneState) {
        defer {
            switchToState(toState)
        }
        
        switch fromState {
        case .Menu:
            menuNode?.removeFromParent()
            menuNode = nil
        case .Playing:
            playingNode?.removeFromParent()
            playingNode = nil
        case .GameOver:
            gameOverNode?.removeFromParent()
            gameOverNode = nil
        }
    }
}
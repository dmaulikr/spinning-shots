//
//  Game.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import Foundation

/**
 Defines the messages sent to a game delegate over the lifetime of a game round.
 */
public protocol GameDelegate {
    func gameDidStart()                                                     // called when a new game starts
    func gameDidEnd(score: Int)                                             // called when a game ends
    
    func gameDidProceedToStage(stage: Int)                                  // called when the game proceeds to the next stage
    func gameDidScore(newScore: Int)                                        // called when the game's score changed
    func gameDidChangeAmountOfBullets(byAmount: Int, totalAmount: Int)      // called when the game's amount of bullets changed
}

/**
 The core, holding and controlling the main game values and actions.
 */
public class Game {
    private var isRunning = false           // indicates whether the game is running
    private(set) public var score = 0       // holds the score value
    private(set) public var stage = 1       // holds the current stage
    private(set) public var bullets = 1     // holds the current amount of bullets
    
    public var gameDelegate: GameDelegate?
    
    /**
     Create a game with default values
     */
    public init() {}
    
    /**
     Start a new game and reset all values.
     */
    public func startNewGame() {
        score = 0
        stage = 1
        bullets = 1
        isRunning = true
        
        gameDelegate?.gameDidStart()
    }
    
    /**
     End the current game.
     */
    public func endGame() {
        isRunning = false
        
        gameDelegate?.gameDidEnd(score)
    }
    
    /**
     Increase the score by one point and add another bullet.
     */
    public func increaseScore() {
        score++
        addBullet()
        
        gameDelegate?.gameDidScore(score)
    }
    
    /**
     Decrease the amount of bullets by one.
     */
    public func shootBullet() {
        bullets--
        
        gameDelegate?.gameDidChangeAmountOfBullets(-1, totalAmount: bullets)
    }
    
    /**
     Increase the amount of bullets by one.
     */
    public func addBullet() {
        bullets++
        
        gameDelegate?.gameDidChangeAmountOfBullets(1, totalAmount: bullets)
    }
    
    /**
     Increase the stage counter.
     */
    public func nextStage() {
        stage++
        
        gameDelegate?.gameDidProceedToStage(stage)
    }
    
    /**
     Perform actions on every game tick.
     */
    public func tick(timeDelta: NSTimeInterval) {
        
    }
}
//
//  Game.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import Foundation


public enum EntityType: UInt32 {
    case Cannon = 1
    case Target = 2
    case Bullet = 4
    
    public static let allTypes = [Cannon, Target, Bullet]
}

public enum ItemType: Int {
    case Cerp
}

public protocol GameDelegate {
    func gameDidStart()
    func gameDidEnd(score: Int)
    
    func gameDidProceedToStage(stage: Int)
    func gameDidScore(newScore: Int)
    func gameDidChangeAmountOfBullets(byAmount: Int, totalAmount: Int)
}

public class Game {
    private var isRunning = false
    private(set) public var score = 0
    private(set) public var stage = 1
    private(set) public var bullets = 1
    
    public var gameDelegate: GameDelegate?
    
    public init() {
        InstanceCountingInitInstance(self)
    }
    
    public func startNewGame() {
        score = 0
        stage = 1
        bullets = 1
        isRunning = true
        
        gameDelegate?.gameDidStart()
    }
    
    public func endGame() {
        isRunning = false
        
        gameDelegate?.gameDidEnd(score)
    }
    
    public func increaseScore() {
        score++
        addBullet()
        
        gameDelegate?.gameDidScore(score)
    }
    
    public func shootBullet() {
        bullets--
        
        gameDelegate?.gameDidChangeAmountOfBullets(-1, totalAmount: bullets)
    }
    
    public func addBullet() {
        bullets++
        
        gameDelegate?.gameDidChangeAmountOfBullets(1, totalAmount: bullets)
    }
    
    public func nextStage() {
        stage++
        
        gameDelegate?.gameDidProceedToStage(stage)
    }
    
    public func tick(timeDelta: NSTimeInterval) {
        
    }
}
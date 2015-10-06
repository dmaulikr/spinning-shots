//
//  Game.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import Foundation


public enum EntityType: UInt32 {
    case Player = 1
    case Target = 2
    case Bullet = 4
    
    public static let allTypes = [Player, Target, Bullet]
}

public enum ItemType: Int {
    case Cerp
}

public protocol GameDelegate {
    func gameDidStart()
    func gameDidEnd(score: Int)
    
    func gameDidScore(newScore: Int)
}

public class Game {
    private var isRunning = false
    private(set) public var score = 0
    
    public var gameDelegate: GameDelegate?
    
    public init() {
        
    }
    
    public func startNewGame() {
        score = 0
        isRunning = true
        
        gameDelegate?.gameDidStart()
    }
    
    public func endGame() {
        isRunning = false
        
        gameDelegate?.gameDidEnd(score)
    }
    
    public func tick(timeDelta: NSTimeInterval) {
        
    }
}
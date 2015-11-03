//
//  Bullet.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import Foundation

/**
 Entity of type Bullet.
 */
public struct Bullet: Entity {
    
    private(set) public var didHit = false      // indicating whether the bullet did hit a target when shot
    private(set) public var wasShot = false     // indicating whether the bullet was shot
    
    /**
    Sets the bullet's hit state to true
    */
    public mutating func hit() {
        didHit = true
    }
    
    /**
     Sets the bullet's shot state to true
     */
    public mutating func shoot() {
        wasShot = true
    }
    
    /**
     Resets the bullet's shot and hit states
     */
    public mutating func reload() {
        wasShot = false
        didHit = false
    }
    
    public var type: EntityType { return .Bullet }
    
}
//
//  Bullet.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import Foundation

public struct Bullet: Entity {
    
    private(set) public var didHit = false
    private(set) public var wasShot = false
    
    public mutating func hit() {
        didHit = true
    }
    
    public mutating func shoot() {
        wasShot = true
    }
    
    public mutating func reload() {
        wasShot = false
        didHit = false
    }
    
    public var type: EntityType {
        return .Bullet
    }
    
}
//
//  Entity.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

/**
Describe the type of an entity.

Note: _This enum is also used for the collision detection bitmasks, this is why the cases should be assigned with continuing numbers as power of 2_
*/
public enum EntityType: UInt32 {
    case Cannon = 1
    case Target = 2
    case Bullet = 4
    case CollisionMarker = 8
}

/**
 An Entity described by its type.
 */
public protocol Entity {
    var type: EntityType { get }
}
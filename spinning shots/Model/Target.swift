//
//  Target.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import UIKit

/**
 Entity of type Target.
 
 Targets are arc's on a 360° circle.
 */
public struct Target: Entity {
    
    private(set) public var degrees: CGFloat    // width of the target in degrees
    private(set) public var rotation: CGFloat   // position of the target in the circle
    
    public var type: EntityType { return .Target }
}
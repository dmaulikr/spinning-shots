//
//  Target.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import UIKit

public struct Target: Entity {
    
    private(set) public var degrees: CGFloat
    private(set) public var rotation: CGFloat
    
    public var type: EntityType {
        return .Target
    }
    
    public init(degrees: CGFloat, rotation: CGFloat) {
        self.degrees = degrees
        self.rotation = rotation
    }
    
}
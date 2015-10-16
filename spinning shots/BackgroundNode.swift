//
//  BackgroundNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

public class BackgroundNode: SKSpriteNode {
    
    public init() {
        super.init(texture: nil, color: Colors.Background, size: Values.sharedValues.sizes.Screen)
        
        zPosition = ZPositions.Background
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
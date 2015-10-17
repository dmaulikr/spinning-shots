//
//  CannonNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

public class CannonNode: SKSpriteNode {
    
    public var cannon: Cannon
    
    public init() {
        self.cannon = Cannon()
        let texture = Textures.sharedTextures.Cannon
        super.init(texture: texture, color: Colors.Clear, size: texture.size())
        zPosition = ZPositions.Cannon
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

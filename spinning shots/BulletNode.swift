//
//  BulletNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

public class BulletNode: SKSpriteNode {
    
    public var bullet: Bullet
    
    public init() {
        self.bullet = Bullet()
        let texture = Textures.sharedTextures.Bullet
        super.init(texture: texture, color: Colors.Clear, size: texture.size())
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
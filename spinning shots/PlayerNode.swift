//
//  PlayerNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

public class PlayerNode: SKSpriteNode {
    
    public var player: Player
    
    public init() {
        self.player = Player()
        let texture = Textures.sharedTextures.Player
        super.init(texture: texture, color: Colors.Clear, size: texture.size())
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

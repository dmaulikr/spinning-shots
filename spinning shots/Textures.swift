//
//  Textures.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

public class Textures {
    public static let sharedTextures = Textures()
    
    public let Player: SKTexture
    public let Target: SKTexture
    public let Bullet: SKTexture
    
    let sizes = Values.sharedValues.sizes
    
    init() {
        Player = SKTexture()
        Target = SKTexture()
        Bullet = SKTexture()
    }
}
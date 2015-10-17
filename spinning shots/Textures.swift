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
    
    public let Cannon: SKTexture
    public let Target: SKTexture
    public let Bullet: SKTexture
    
    public let PlayButton: SKTexture
    
    let sizes = Values.sharedValues.sizes
    
    init() {
        Cannon = SKTexture(image: StyleKit.imageOfCannon(size: sizes.Cannon))
        Target = SKTexture()
        Bullet = SKTexture(image: StyleKit.imageOfBullet(size: sizes.Bullet))
        
        PlayButton = SKTexture(image: StyleKit.imageOfPlayButton(diameter: sizes.MenuButtonPlayDiameter))
    }
}

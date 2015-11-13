//
//  Textures.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

/**
 Global access to the game's textures via a singleton instance.
 
 Textures are loaded on the first access of the singleton instance.
 */
public class Textures {
    public static let sharedTextures = Textures()
    
    public let Border: SKTexture
    public let BorderHalf: SKTexture
    
    public let Cannon: SKTexture
    public let Bullet: SKTexture
    
    private let PlayButton: SKTexture
    private let HomeButton: SKTexture
    private let ShareButton: SKTexture
    private let GameCenterButton: SKTexture
    
    let sizes = Values.sharedValues.sizes
    
    /**
     Load the textures.
     */
    init() {
        Border = SKTexture(image: StyleKit.imageOfBorder(diameter: sizes.BorderDiameter, strokeWidth: sizes.BorderStrokeWidth, isFullCircle: true))
        BorderHalf = SKTexture(image: StyleKit.imageOfBorder(diameter: sizes.BorderDiameter, strokeWidth: sizes.BorderStrokeWidth, isFullCircle: false))
        
        Cannon = SKTexture(image: StyleKit.imageOfCannon(size: sizes.Cannon))
        Bullet = SKTexture(image: StyleKit.imageOfBullet(size: sizes.Bullet))
        
        PlayButton = SKTexture(image: StyleKit.imageOfPlayButton(diameter: sizes.MenuButtonPlayDiameter))
        HomeButton = SKTexture(image: StyleKit.imageOfHomeButton(diameter: sizes.GameOverButtonHomeDiameter))
        ShareButton = SKTexture(image: StyleKit.imageOfShareButton(diameter: sizes.GameOverButtonShareDiameter))
        GameCenterButton = SKTexture(image: StyleKit.imageOfGameCenterButton(diameter: sizes.GameOverButtonGameCenterDiameter))
    }
    
    /**
     Get the button texture.
     - parameter item: button item
     */
    public func buttonItem(item: ButtonItem) -> SKTexture {
        let texture: SKTexture
        switch item {
        case .Play: texture = PlayButton
        case .Home: texture = HomeButton
        case .Share: texture = ShareButton
        case .GameCenter: texture = GameCenterButton
        }
        return texture
    }
}

//
//  Button.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-17.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

public enum ButtonItem {
    case Play
    case Home
    case Share
    case GameCenter
}

public class Button: SKSpriteNode {
    
    private var item: ButtonItem
    
    public init(item: ButtonItem) {
        self.item = item
        let texture = Button.textureForItem(item)
        super.init(texture: texture, color: Colors.Clear, size: texture.size())
        zPosition = ZPositions.UIButton
        
        InstanceCountingInitInstance(self)
    }
    
    private static func textureForItem(item: ButtonItem) -> SKTexture {
        let texture: SKTexture
        switch item {
        case .Play: texture = Textures.sharedTextures.PlayButton
        case .Home: texture = Textures.sharedTextures.HomeButton
        case .Share: texture = Textures.sharedTextures.ShareButton
        case .GameCenter: texture = Textures.sharedTextures.GameCenterButton
        }
        return texture
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
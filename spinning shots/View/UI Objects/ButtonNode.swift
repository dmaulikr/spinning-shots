//
//  ButtonNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-17.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

/**
 Items for which a button is available.
 */
public enum ButtonItem {
    case Play
    case Home
    case Share
    case GameCenter
}

/**
 Button node for a specifc button item.
 */
public class ButtonNode: SKSpriteNode {
    
    private var item: ButtonItem
    
    /**
     Create a button node.
     - parameter item: button item
     */
    public init(item: ButtonItem) {
        self.item = item
        let texture = Textures.sharedTextures.buttonItem(item)
        super.init(texture: texture, color: Colors.Clear, size: texture.size())
        zPosition = ZPositions.UIButton
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
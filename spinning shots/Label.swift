//
//  Label.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

public class Label: SKLabelNode {
    
    public init(text: String, fontSize: CGFloat, fontColor: UIColor) {
        super.init()

        self.text = text
        self.fontSize = fontSize
        self.fontColor = fontColor
        
        zPosition = ZPositions.UILabel
    }
    
    public convenience init(text: String, fontSize: CGFloat) {
        self.init(text: text, fontSize: fontSize, fontColor: .blackColor())
    }
    
    override public init() {
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
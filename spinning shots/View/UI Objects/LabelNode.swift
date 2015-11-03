//
//  LabelNode.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

/**
 Convenience Label
 */
public class LabelNode: SKLabelNode {
    
    /**
     Create a label node.
     - parameter text: text to display
     - parameter fontSize: size of the label's font
     - parameter fontColor: color of the label's font
     */
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
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
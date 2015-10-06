//
//  Values.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import UIKit

public class Values {
    public static let sharedValues = Values()
    
    public let sizes: Sizes
    
    public struct Sizes {
        public let Screen: CGSize
        
        private init() {
            let delegate = UIApplication.sharedApplication().delegate! as! AppDelegate
            let gameVC = delegate.window!.rootViewController as! ViewController
            
            Screen = gameVC.view.frame.size
        }
    }
    
    init() {
        self.sizes = Sizes()
    }
}
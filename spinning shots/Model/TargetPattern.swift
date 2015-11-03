//
//  TargetPattern.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-10.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import CoreGraphics

/**
 A pattern of targets on a 360° circle
 */
public class TargetPattern {
    
    private(set) public var targets: [Target]       // the pattern's targets
    private(set) public var gap: CGFloat            // gap between targets in degrees
    private(set) public var targetSize: CGFloat     // size of the targets in degrees
    private(set) public var count: Int              // count of targets in this pattern
    
    private let MaxDegrees: CGFloat = 360
    
    /**
     TargetPatterns can be created using different constructors intended for different scenarios.
     Each constructor first calculates its needed values and then they all call a generic method
     to actually create the targets.
     */
     
     
     /**
     Create a pattern with an distinct amount of and gap between targets. The size of the targets
     is calculated automatically.
     - parameter targetCount: amount of targets
     - parameter gap: gap between targets
     */
    public init(targetCount: Int, gap: CGFloat) {
        self.targets = []
        self.gap = gap
        let gapsTotal = gap * CGFloat(targetCount)
        self.targetSize = (MaxDegrees - gapsTotal) / CGFloat(targetCount)
        self.count = targetCount
        
        createTargets()
    }
    
    /**
     Create a pattern with targets of distinct size. The gap between the targets
     is calculated automatically with the remaining space left on the circle after filling
     it with targets of the specified size.
     - parameter targetSize: size of targets
     */
    public init(targetSize: CGFloat) {
        self.targets = []
        self.targetSize = targetSize
        self.count = Int(MaxDegrees / targetSize)
        
        let remainingSize = MaxDegrees - (targetSize * CGFloat(count))
        self.gap = remainingSize / CGFloat(count)
        
        createTargets()
    }
    
    /**
     Create a pattern with an distinct amount and size of targets. The gap between the targets
     is calculated automatically with the remaining space left on the circle after placing the
     specified amount of targets with the specified size.
     - parameter targetCount: amount of targets
     - parameter targetSize: size of targets
     */
    public init(targetCount: Int, targetSize: CGFloat) {
        self.targets = []
        self.targetSize = targetSize
        
        let sizeTotal = targetSize * CGFloat(targetCount)
        let remainingSize = MaxDegrees - sizeTotal
        self.gap = remainingSize / CGFloat(targetCount)
        self.count = targetCount
        
        createTargets()
    }
    
    /**
     Create targets using the previously calculated values. Should only be called by the classe's constructors.
     */
    private func createTargets() {
        for i in 0..<count {
            let target = Target(degrees: targetSize, rotation: 90 + targetSize * CGFloat(i) + gap * CGFloat(i))
            targets.append(target)
        }
    }
}
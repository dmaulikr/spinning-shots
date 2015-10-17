//
//  TargetPattern.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-10.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import CoreGraphics

public class TargetPattern {
    
    private(set) public var targets: [Target]
    private(set) public var gap: CGFloat
    private(set) public var targetSize: CGFloat
    private(set) public var count: Int
    
    private let MaxDegree: CGFloat = 360
    
    public init(targetCount: Int, gap: CGFloat) {
        self.targets = []
        self.gap = gap
        let gapsTotal = gap * CGFloat(targetCount)
        self.targetSize = (MaxDegree - gapsTotal) / CGFloat(targetCount)
        self.count = targetCount
        
        createTargets()
        
        InstanceCountingInitInstance(self)
    }
    
    public init(targetSize: CGFloat) {
        self.targets = []
        self.targetSize = targetSize
        self.count = Int(MaxDegree / targetSize)
        
        let remainingSize = MaxDegree - (targetSize * CGFloat(count))
        self.gap = remainingSize / CGFloat(count)
        
        createTargets()
        
        InstanceCountingInitInstance(self)
    }
    
    public init(targetCount: Int, targetSize: CGFloat) {
        self.targets = []
        self.targetSize = targetSize
        
        let sizeTotal = targetSize * CGFloat(targetCount)
        let remainingSize = MaxDegree - sizeTotal
        self.gap = remainingSize / CGFloat(targetCount)
        self.count = targetCount
        
        createTargets()
        
        InstanceCountingInitInstance(self)
    }
    
    private func createTargets() {
        for i in 0..<count {
            let target = Target(degrees: targetSize, rotation: targetSize * CGFloat(i) + gap * CGFloat(i))
            targets.append(target)
        }
    }
}
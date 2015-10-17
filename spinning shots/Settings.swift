//
//  Settings.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import Foundation

public class Settings {
    public static let sharedManager = Settings()
    
    private let SettingsLaunchedBeforeKey = "WasLaunchedBefore"
    private let SettingsBestScoreKey = "BestScore"
    private let SettingsMusicEnabledKey = "MusicEnabled"
    
    private var wasLaunchedBefore: Bool!
    private(set) public var bestScore: Int!
    private(set) public var isMusicEnabled: Bool!
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    private init() {
        self.wasLaunchedBefore = defaults.boolForKey(SettingsLaunchedBeforeKey)
        
        if !self.wasLaunchedBefore {
            setBestScore(0)
            setIsMusicEnabled(true)
            
            setWasLaunchedBefore(true)
        } else {
            self.bestScore = defaults.integerForKey(SettingsBestScoreKey)
            self.isMusicEnabled = defaults.boolForKey(SettingsMusicEnabledKey)
        }
        
        InstanceCountingInitInstance(self)
    }
    
    private func setWasLaunchedBefore(launchedBefore: Bool) {
        self.wasLaunchedBefore = launchedBefore
        defaults.setBool(wasLaunchedBefore, forKey: SettingsLaunchedBeforeKey)
    }
    
    public func setBestScore(score: Int) {
        self.bestScore = score
        defaults.setInteger(bestScore, forKey: SettingsBestScoreKey)
    }
    
    public func setIsMusicEnabled(enabled: Bool) {
        self.isMusicEnabled = enabled
        defaults.setBool(isMusicEnabled, forKey: SettingsMusicEnabledKey)
    }
}
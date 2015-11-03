//
//  Settings.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import Foundation

/**
 Global Settings Manager.
 */
public class Settings {
    public static let sharedManager = Settings()                    // singleton instance
    
    // Setting Properties
    private var wasLaunchedBefore: Bool!
    private(set) public var bestScore: Int!
    private(set) public var isMusicEnabled: Bool!
    
    // Setting Property Keys
    private let SettingsLaunchedBeforeKey = "WasLaunchedBefore"
    private let SettingsBestScoreKey = "BestScore"
    private let SettingsMusicEnabledKey = "MusicEnabled"
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    /**
     Load the settings.
     */
    private init() {
        // check if this is the first launch
        self.wasLaunchedBefore = defaults.boolForKey(SettingsLaunchedBeforeKey)
        
        if !self.wasLaunchedBefore {
            // set default values on first launch
            setBestScore(0)
            setIsMusicEnabled(true)
            
            setWasLaunchedBefore(true)
        } else {
            // assign loaded values
            self.bestScore = defaults.integerForKey(SettingsBestScoreKey)
            self.isMusicEnabled = defaults.boolForKey(SettingsMusicEnabledKey)
        }
    }
    
    /**
     Set whether the application was launched before and write it to NSUserDefaults.
     - parameter launchedBefore: toggle
     */
    private func setWasLaunchedBefore(launchedBefore: Bool) {
        self.wasLaunchedBefore = launchedBefore
        defaults.setBool(wasLaunchedBefore, forKey: SettingsLaunchedBeforeKey)
    }
    
    /**
     Set the best score and write it to NSUserDefaults.
     - parameter score: score to set as best
     */
    public func setBestScore(score: Int) {
        self.bestScore = score
        defaults.setInteger(bestScore, forKey: SettingsBestScoreKey)
    }
    
    /**
     Set toggle whether music playbac is enabled and write it to NSUserDefaults.
     - parameter enabled: toggle
     */
    public func setIsMusicEnabled(enabled: Bool) {
        self.isMusicEnabled = enabled
        defaults.setBool(isMusicEnabled, forKey: SettingsMusicEnabledKey)
    }
}
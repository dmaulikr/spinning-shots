//
//  SoundManager.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit
import AVFoundation

/**
 Available sounds to play.
 */
public enum Sound {
    case Hit
    case Miss
    case Heart
    
    public static var allSounds = [Hit, Miss, Heart]
    
    public var fileName: String {
        switch self {
        case .Hit: return "sfx-hit.wav"
        case .Miss: return "sfx-miss.wav"
        case .Heart: return "sfx-heart.wav"
        }
    }
}

/**
 Global Sound Manager.
 */
public class SoundManager {
    public static let sharedManager = SoundManager()    // singleton instance
    
    private(set) public var  scene: SKScene?            // scene used to play the sounds
    private var soundActions = [Sound : SKAction]()     // sounds to play
    
    private init() {
        // NOTE:    Do not uncomment yet, because the sounds are not yet added to the project.
        //          App will crash when trying to load them ;)
        //initSounds() // TODO: uncomment for prod
    }
    
    /**
     Assign a scene on which the sounds should be played.
     - parameter scene: scene to be used for playback
     */
    public func setup(scene: SKScene) {
        self.scene = scene
    }
    
    /**
     Load all sound actions.
     */
    private func initSounds() {
        soundActions = [:]
        for sound in Sound.allSounds {
            soundActions[sound] = actionForSound(sound)
        }
    }
    
    /**
     Load a specific sound action.
     */
    private func actionForSound(sound: Sound) -> SKAction {
        return SKAction.playSoundFileNamed(sound.fileName, waitForCompletion: false)
    }
    
    /**
     Vibrate the physical device.
     */
    public func vibrate() {
        //AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    /**
     Play a sound.
     - parameter sound: sound to be played
     */
    public func playSound(sound: Sound) {
        // check whether music playback is enabled in Settings and whether the sound is actually loaded
        guard Settings.sharedManager.isMusicEnabled == true, let scene = scene, let soundAction = soundActions[sound] else { return }
        scene.runAction(soundAction)
    }
}

//
//  SoundManager.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit
import AVFoundation

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

public class SoundManager {
    public static let sharedManager = SoundManager()
    
    private(set) public var  scene: SKScene?
    private var soundActions = [Sound : SKAction]()
    
    private init() {
        //initSounds()
        
        InstanceCountingInitInstance(self)
    }
    
    public func setup(scene: SKScene) {
        self.scene = scene
    }
    
    private func initSounds() {
        soundActions = [:]
        for sound in Sound.allSounds {
            soundActions[sound] = actionForSound(sound)
        }
    }
    
    private func actionForSound(sound: Sound) -> SKAction {
        return SKAction.playSoundFileNamed(sound.fileName, waitForCompletion: false)
    }
    
    public func playSound(sound: Sound) {
        guard Settings.sharedManager.isMusicEnabled == true, let scene = scene, let soundAction = soundActions[sound] else { return }
        scene.runAction(soundAction)
    }
}

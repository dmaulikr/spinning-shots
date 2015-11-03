//
//  AppDelegate.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import UIKit
import SpriteKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? = UIWindow(frame: UIScreen.mainScreen().bounds)
    var gameVC: ViewController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        guard let window = window else { return false }
        
        // preload stuff
        Values.sharedValues
        Textures.sharedTextures
        
        gameVC = ViewController()
        window.rootViewController = gameVC
        window.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        gameVC?.scene.paused = true
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        gameVC?.scene.paused = false
    }
    
}


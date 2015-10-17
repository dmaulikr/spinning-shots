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

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        if let view = window?.rootViewController?.view as? SKView {
            view.scene?.paused = true
        }
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        if let view = window?.rootViewController?.view as? SKView {
            view.scene?.paused = false
        }
    }

}


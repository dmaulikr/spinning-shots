//
//  ViewController.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    var scene: Scene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup the view + scene
        let skView = SKView(frame: view.frame)
        view.addSubview(skView)
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.showsPhysics = false
        skView.ignoresSiblingOrder = true
        scene = Scene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        skView.presentScene(scene)
        
        // TODO: uncomment for prod
        //GameCenterManager.sharedManager.setup(withPresentingViewController: self)
        //SoundManager.sharedManager.setup(scene)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("shareScore:"), name: "ShareScore", object: nil)
    }
    
    /**
     Share the game's score via the native share extension.
     
     Note: _Should only be called by the appropriate Notification via NSNotificationCenter, not manually.
     
     - parameter notification: The notification containing the needed information
     */
    func shareScore(notification: NSNotification) {
        // retrieve information from the notification
        let score: Int = notification.userInfo!["Score"] as! Int
        let textToShare = "I just scored \(score) points in #SpinningShots. Get the app at https://itunes.apple.com/us/app/spinning-shots/id1046883607?ls=1&mt=8"
        
        // set up a UIActivityVC for sharing the score
        let objectsToShare = [textToShare]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
        
        // present the VC
        // Note: this implementation contains a workaround for an iOS 8 bug on iPad with using the popoverPresentationController
        // TODO: check if workaround is still needed
        if activityVC.respondsToSelector(Selector("popoverPresentationController")) {
            if let presentationController = activityVC.popoverPresentationController {
                let touchLocation = CGPointFromString(notification.userInfo!["TouchLocation"] as! String)
                let buttonSize = CGSizeFromString(notification.userInfo!["ButtonSize"] as! String)
                
                let tapView = UIView(frame: CGRect(x: touchLocation.x, y: view.bounds.height - touchLocation.y, width: buttonSize.width, height: buttonSize.height))
                presentationController.sourceView = tapView
            }
        }
        
        presentViewController(activityVC, animated: true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
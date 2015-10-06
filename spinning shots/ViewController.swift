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
        
        scene = Scene(size: view.bounds.size)
        let skView = self.view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .AspectFill
        skView.presentScene(scene)
        
        //GameCenterManager.sharedManager.setup(withPresentingViewController: self)
        //SoundManager.sharedManager.setup(scene)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("shareScore:"), name: "ShareScore", object: nil)
    }
    
    func shareScore(notification: NSNotification) {
        let score: Int = notification.userInfo!["Score"] as! Int
        let textToShare = "I just scored \(score) points in #SpinningShots. Get the app at https://itunes.apple.com/us/app/spinning-shots/id1046883607?ls=1&mt=8"
        
        let objectsToShare = [textToShare]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
        
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
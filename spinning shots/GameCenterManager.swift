//
//  GameCenterManager.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import GameKit

public class GameCenterManager: NSObject, GKGameCenterControllerDelegate {
    public static let sharedManager = GameCenterManager()
    
    private var presentingViewController: UIViewController?
    
    private let GameCenterScoreLeaderboardIdentifier = "spinning-shots_leaderboard_score"
    
    public func setup(withPresentingViewController viewController: UIViewController) {
        presentingViewController = viewController
        authenticatePlayer()
        
        InstanceCountingInitInstance(self)
    }
    
    public func reportScore(score: Int) {
        let gkScore = GKScore(leaderboardIdentifier: GameCenterScoreLeaderboardIdentifier)
        gkScore.value = Int64(score)
        
        GKScore.reportScores([gkScore]) { (error) -> Void in
            if error != nil { print("Error while reporting score") }
        }
    }
    
    public func showLeaderboards() {
        let gcController = GKGameCenterViewController()
        gcController.gameCenterDelegate = self
        gcController.viewState = .Leaderboards
        
        guard let presentingViewController = presentingViewController else {
            print("Error while showing GameCenter Leadboard: PresentingViewController not set")
            return
        }
        
        presentingViewController.presentViewController(gcController, animated: true, completion: nil)
    }
    
    private func authenticatePlayer() {
        let player = GKLocalPlayer.localPlayer()
        
        player.authenticateHandler = { (viewController, error) in
            if error != nil {
                print("Error while authenticating player: \(error?.localizedDescription)")
                print(" -> error: \(error?.localizedDescription)")
            }
            
            if let presentingViewController = self.presentingViewController {
                if let viewController = viewController {
                    print("Error while authenticating player: the to-be-presented viewController is not nil and should be presented")
                    presentingViewController.presentViewController(viewController, animated: true, completion: nil)
                } else {
                    // successfully authenticated player
                }
            } else {
                print("Error while authenticating player: PresentingViewController not set")
            }
        }
    }
    
    public func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}

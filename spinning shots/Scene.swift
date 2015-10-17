//
//  Scene.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

public protocol SceneDelegate {
    func completedTransitionFromState(fromState: SceneState, andShouldNowSwitchToState toState: SceneState)
}

public enum SceneState: Int {
    case Menu, Playing, GameOver
}

public class Scene: SKScene, GameDelegate {
    
    private var menuNode: MenuNode?
    private var playingNode: PlayingNode?
    private var gameOverNode: GameOverNode?
    
    private var sceneState: SceneState!
    private var game: Game!
    
    private var isGameRunning = false
    private var lastUpdateTime: NSTimeInterval = 0.0
    private var dt: NSTimeInterval = 0.0
    
    private var backgroundNode: BackgroundNode!
    private var borderNode: OvalBorderNode!
    private var objectsNode: SKNode!
    private var rotationNode: SKNode!
    
    private var cannonNode: CannonNode!
    private var targetNode: SKSpriteNode!
    private var bulletNodes: Set<BulletNode>!
    private var currentPatternNodes: [TargetNode] = []
    
    private let sizes = Values.sharedValues.sizes
    private let positions = Values.sharedValues.positions
    private let speeds = Values.sharedValues.speeds
    
    public override func didMoveToView(view: SKView) {
        InstanceCountingInitInstance(self)
        
        game = Game()
        game.gameDelegate = self
        
        initBackgroundNode()
        initObjectsNode()
        initRotationNode()
        initBorderNode()
        
        initPhysics()
        
        switchToState(.Menu)
    }
    
    public func gameDidStart() {
        isGameRunning = true
    }
    
    public func gameDidEnd(score: Int) {
        isGameRunning = false
        
        // remove entities etc from ui
        objectsNode.removeAllChildren()
        rotationNode.removeAllChildren()
        objectsNode.addChild(rotationNode)
        
        saveScore(score)
        
        playingNode?.close(withTargetState: .GameOver)
    }
    
    public func gameDidProceedToStage(stage: Int) {
        let pattern = TargetNodeCreator.patternForStage(stage)
        loadPattern(pattern)
    }
    
    public func gameDidScore(newScore: Int) {
        playingNode?.updateScoreLabel(withScore: newScore)
    }
    
    public func gameDidChangeAmountOfBullets(byAmount: Int, totalAmount: Int) {
        playingNode?.updateBulletsLabel(withBullets: totalAmount)
    }
    
    private func initBackgroundNode() {
        backgroundNode = BackgroundNode()
        backgroundNode.position = size.middle
        addChild(backgroundNode)
    }
    
    public func startNewGame() {
        initCannonNode()
        bulletNodes = []
        
        game.startNewGame()
    }
    
    private func initObjectsNode() {
        objectsNode = SKNode()
        addChild(objectsNode)
    }
    
    private func initBorderNode() {
        borderNode = OvalBorderNode(diameter: sizes.BorderDiameter, strokeWidth: sizes.BorderStrokeWidth)
        borderNode.position = positions.OvalBorderNode
        //objectsNode.addChild(borderNode)
    }
    
    private func initRotationNode() {
        rotationNode = SKNode()
        rotationNode.position = positions.ScreenMiddle
        objectsNode.addChild(rotationNode)
    }
    
    private func initCannonNode() {
        cannonNode = CannonNode()
        cannonNode.position = positions.Cannon
        objectsNode.addChild(cannonNode)
    }
    
    private func initPhysics() {
        physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        physicsWorld.contactDelegate = self
    }
    
    private func loadPattern(pattern: TargetPattern) {
        currentPatternNodes = TargetNodeCreator.create(pattern)
        
        let waitTime = 0.05
        for (index, arc) in currentPatternNodes.enumerate() {
            arc.alpha = 0.0
            rotationNode.addChild(arc)
            
            let wait = SKAction.waitForDuration(waitTime * Double(index))
            let fadeIn = SKAction.fadeAlphaTo(1.0, duration: ActionDuration)
            arc.runAction(SKAction.sequence([wait, fadeIn]))
        }
        
        let totalWait = SKAction.waitForDuration(waitTime * Double(currentPatternNodes.count + 1))
        runAction(SKAction.sequence([totalWait, SKAction.runBlock({ () -> Void in
            self.currentPatternNodes.forEach { $0.shouldRotate = true }
        })]))
    }
    
    private func shootBullet() {
        if game.bullets > 0 {
            game.shootBullet()
            
            let bulletNode = BulletNode()
            bulletNode.position = positions.ScreenMiddle
            objectsNode.addChild(bulletNode)
            bulletNodes.insert(bulletNode)
        }
    }
    
    public override func update(currentTime: NSTimeInterval) {
        super.update(currentTime)
        
        dt =  lastUpdateTime > 0 ? currentTime - lastUpdateTime : 0.0
        if dt > 1.0/30.0 {
            dt = 1.0/30.0
        }
        
        lastUpdateTime = currentTime
        
        rotateTargetNodes()
        
        guard isGameRunning else { return }
        
        game.tick(dt)
        moveBullets(dt)
    }
    
    private func moveBullets(dt: NSTimeInterval) {
        for bullet in bulletNodes {
            bullet.moveBy(CGPoint(x: 0, y: speeds.Bullet), dt: dt)
            
            if bullet.position.y > positions.ScreenMiddle.y + sizes.PlayingAreaDiameter / 2.0 - bullet.size.height / 2.0 {
                bullet.removeFromParent()
                bulletNodes.remove(bullet)
                
                if game.bullets == 0 {
                    game.endGame()
                }
            }
        }
    }
    
    private func rotateTargetNodes() {
        for targetNode in currentPatternNodes where targetNode.shouldRotate == true {
            let direction: CGFloat = game.stage % 2 == 1 ? 1 : -1
            targetNode.zRotation += CGFloat(dt) * speeds.Target * direction
        }
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        switch sceneState as SceneState {
        case .Menu: menuNode?.touchesBegan(touches, withEvent: event)
        case .Playing:
            playingNode?.touchesBegan(touches, withEvent: event)
            shootBullet()
        case .GameOver: gameOverNode?.touchesBegan(touches, withEvent: event)
        }
    }
    
    private func switchToState(state: SceneState) {
        func switchToMenuState() {
            sceneState = .Menu
            
            let pattern = TargetNodeCreator.patternForStage(game.stage)
            loadPattern(pattern)
            
            menuNode = MenuNode(sceneDelegate: self)
            addChild(menuNode!)
        }
        
        func switchToPlayingState() {
            sceneState = .Playing
            
            playingNode = PlayingNode(sceneDelegate: self)
            addChild(playingNode!)
            
            startNewGame()
        }
        
        func switchToGameOverState() {
            sceneState = .GameOver
            
            gameOverNode = GameOverNode(sceneDelegate: self, score: game.score)
            addChild(gameOverNode!)
        }
        
        switch state {
        case .Menu: switchToMenuState()
        case .Playing: switchToPlayingState()
        case .GameOver: switchToGameOverState()
        }
    }
    
    private func saveScore(score: Int) {
        let bestScore = Settings.sharedManager.bestScore
        if score > bestScore {
            //GameCenterManager.sharedManager.reportScore(score) // TODO: activate
            Settings.sharedManager.setBestScore(score)
        }
    }
    
}

extension Scene: SKPhysicsContactDelegate {
    public func didBeginContact(contact: SKPhysicsContact) {
        let bulletBody: SKPhysicsBody = contact.bodyA.categoryBitMask == EntityType.Bullet.rawValue ? contact.bodyA : contact.bodyB
        let targetBody: SKPhysicsBody = contact.bodyA.categoryBitMask == EntityType.Target.rawValue ? contact.bodyA : contact.bodyB
        
        if let bulletNode = bulletBody.node as? BulletNode {
            var bullet = bulletNode.bullet
            
            if !bullet.didHit {
                bullet.hit()
                game.increaseScore()
                
                bulletNode.removeFromParent()
                bulletNodes.remove(bulletNode)
                
                let index = currentPatternNodes.indexOf(targetBody.node as! TargetNode)!
                currentPatternNodes.removeAtIndex(index)
                targetBody.node?.removeFromParent()
                
                if currentPatternNodes.count == 0 {
                    game.nextStage()
                }
            }
        }
        
        
    }
}

extension Scene: SceneDelegate {
    public func completedTransitionFromState(fromState: SceneState, andShouldNowSwitchToState toState: SceneState) {
        defer {
            switchToState(toState)
        }
        
        switch fromState {
        case .Menu:
            menuNode?.removeFromParent()
            menuNode = nil
        case .Playing:
            playingNode?.removeFromParent()
            playingNode = nil
        case .GameOver:
            gameOverNode?.removeFromParent()
            gameOverNode = nil
        }
    }
}
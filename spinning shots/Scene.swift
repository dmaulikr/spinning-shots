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
    private var bulletNode: BulletNode!
    private var currentPatternNodes: [TargetNode] = []
    
    private var shouldReloadBulletOnNextUpdate = false
    
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
        if totalAmount > 0 {
            shouldReloadBulletOnNextUpdate = true
        }
    }
    
    private func initBackgroundNode() {
        backgroundNode = BackgroundNode()
        backgroundNode.position = size.middle
        addChild(backgroundNode)
    }
    
    public func startNewGame() {
        initNewGame(completion: {
            self.game.startNewGame()
        })
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
    
    private func initNewGame(completion completion: () -> Void) {
        cannonNode = CannonNode()
        cannonNode.alpha = 0.0
        cannonNode.setScale(0.0)
        cannonNode.position = positions.Cannon
        objectsNode.addChild(cannonNode)
        
        bulletNode = BulletNode()
        bulletNode.position = positions.Cannon
        
        let cannonAction = SKAction.fadeInAndScaleUp(ActionDuration)
        let bulletAction = SKAction.moveTo(positions.CannonBullet, duration: ActionDuration / 3.0)
        
        let totalInitDuration = cannonAction.duration + bulletAction.duration
        
        cannonNode.runAction(cannonAction) {
            self.objectsNode.addChild(self.bulletNode)
            self.bulletNode.runAction(bulletAction)
        }
        
        runAction(SKAction.sequence([
            SKAction.waitForDuration(totalInitDuration),
            SKAction.runBlock(completion)
            ]))
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
        if game.bullets > 0 && !bulletNode.bullet.wasShot {
            game.shootBullet()
            bulletNode.bullet.shoot()
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
        reloadBulletIfNeeded()
        moveBullets(dt)
    }
    
    private func reloadBulletIfNeeded() {
        if shouldReloadBulletOnNextUpdate {
            shouldReloadBulletOnNextUpdate = false
            bulletNode.position = positions.Cannon
            
            bulletNode.bullet.reload()
            
            let move = SKAction.moveTo(positions.CannonBullet, duration: ActionDuration / 3.0)
            bulletNode.runAction(move)
        }
    }
    
    private func moveBullets(dt: NSTimeInterval) {
        if bulletNode.bullet.wasShot {
            bulletNode.moveBy(CGPoint(x: 0, y: speeds.Bullet), dt: dt)
            
            if bulletNode.position.y > positions.ScreenMiddle.y + sizes.PlayingAreaDiameter / 2.0 - bulletNode.size.height / 2.0 {
                bulletNode.removeFromParent()
                
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
            if isGameRunning { shootBullet() }
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
        let targetBody: SKPhysicsBody = contact.bodyA.categoryBitMask == EntityType.Target.rawValue ? contact.bodyA : contact.bodyB
        
        if !bulletNode.bullet.didHit {
            bulletNode.bullet.hit()
            
            game.increaseScore()
            
            let index = currentPatternNodes.indexOf(targetBody.node as! TargetNode)!
            currentPatternNodes.removeAtIndex(index)
            targetBody.node?.removeFromParent()
            
            if currentPatternNodes.count == 0 {
                game.nextStage()
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
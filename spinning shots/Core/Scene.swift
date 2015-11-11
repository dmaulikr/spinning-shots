//
//  Scene.swift
//  spinning shots
//
//  Created by Marc Zobec on 2015-10-06.
//  Copyright © 2015 Marc Zobec. All rights reserved.
//

import SpriteKit

/**
 States the Scene can be in.
 */
public enum SceneState: Int {
    case Menu, Playing, GameOver
}

/**
 Conforming types are informed about scene transition changes.
 */
public protocol SceneTransitionDelegate {
    func completedTransitionFromState(fromState: SceneState, andShouldNowSwitchToState toState: SceneState)
}

/**
 Directions the game objects can rotate to.
 */
public enum RotationDirection: Int {
    case Clockwise = -1
    case CounterClockwise = 1
    
    public mutating func flip() {
        self = (self == .Clockwise ? CounterClockwise : Clockwise)
    }
}

/**
 Core visual & interaction layer of the game.
 Controls the game via a Game instance.
 */
public class Scene: SKScene {
    
    //MARK: - Variables
    private var menuNode: MenuNode?                     // holds the menu state UI
    private var playingNode: PlayingNode?               // holds the playing state UI
    private var gameOverNode: GameOverNode?             // holds the game over state UI
    
    private var sceneState: SceneState!                 // keeps track of the scene's current state
    private var game: Game!                             // game instance
    
    private var isGameRunning = false                   // indicates whether the game is running
    private var lastUpdateTime: NSTimeInterval = 0.0    // helper for the update-time calculating
    private var dt: NSTimeInterval = 0.0                // indicates the time delta between now and the last update
    
    private var backgroundNode: BackgroundNode!         // background of the scene
    private var collisionLineNode: LineNode!                     // invisible, used for collision detection
    
    private var rotationNode: SKNode!                   // holds all game objects that should rotate
    private var objectsNode: SKNode!                    // holds the rotation node + all game objects that shouldn't rotate
    
    private var cannonNode: CannonNode!                 // cannon
    private var bulletNode: BulletNode!                 // bullet
    private var currentPatternNodes: [TargetNode] = []  // target nodes
    
    private var shouldReloadBulletOnNextUpdate = false  // indicates whether the cannon should be reloaded on the next update
    private var rotationDirection: RotationDirection!   // indicates the rotation direction
    
    //MARK: - Constants
    private let sizes = Values.sharedValues.sizes
    private let positions = Values.sharedValues.positions
    private let speeds = Values.sharedValues.speeds
    
    //MARK: - View Lifecycle
    public override func didMoveToView(view: SKView) {
        setupOnLaunch()
        
        switchToState(.Menu)
    }
    
    //MARK: - Setup
    
    /**
    Initial scene setup.
    */
    private func setupOnLaunch() {
        setupGameInstance()
        setupBackgroundNode()
        setupObjectsNode()
        setupCollisionLineNode()
        setupRotationNode()
        setupPhysics()
    }
    
    /**
     Create a game instance + connect the gameDelegate to self.
     */
    private func setupGameInstance() {
        game = Game()
        game.gameDelegate = self
    }
    
    /**
     Create the background node and add it to the scene.
     */
    private func setupBackgroundNode() {
        backgroundNode = BackgroundNode()
        backgroundNode.position = positions.ScreenMiddle
        addChild(backgroundNode)
    }
    
    /**
     Create the objects node and add it to the scene.
     */
    private func setupObjectsNode() {
        objectsNode = SKNode()
        addChild(objectsNode)
    }
    
    /**
     Create the collision line node.
     
     Note: _The node is not getting added to the scene automatically. It should be added manually once it's needed._
     */
    private func setupCollisionLineNode() {
        collisionLineNode = LineNode(length: sizes.PlayingAreaDiameter, orientation: .Horizontal)
        collisionLineNode.position = positions.ScreenMiddle
    }
    
    /**
     Create the rotation node and add it to the objects node.
     */
    private func setupRotationNode() {
        rotationNode = SKNode()
        rotationNode.position = positions.ScreenMiddle
        objectsNode.addChild(rotationNode)
    }
    
    /**
     Configure the physics world.
     */
    private func setupPhysics() {
        physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        physicsWorld.contactDelegate = self
    }
    
    /**
     Create a new game
     
     - parameter completion: Executed when game setup is completed (incl. animations).
     */
    private func setupNewGame(completion completion: () -> Void) {
        setupCannonNode()
        setupBulletNode()
        
        // Initial game object animations:
        // - fade in & scale up cannon
        // - move bullet up to make it stick out of the cannon a bit
        let cannonAction = SKAction.fadeInAndScaleUp(ActionDuration)
        let bulletAction = SKAction.moveTo(positions.CannonBullet, duration: ActionDuration / 3.0)
        
        cannonNode.runAction(cannonAction) {
            self.objectsNode.addChild(self.bulletNode)
            self.bulletNode.runAction(bulletAction)
        }
        
        // Calculate the total duration of the running actions
        let totalInitDuration = cannonAction.duration + bulletAction.duration
        
        // Wait for the actions to be completed, then execute the completion closure
        runAction(SKAction.sequence([
            SKAction.waitForDuration(totalInitDuration),
            SKAction.runBlock(completion)
            ]))
    }
    
    /**
     Create the cannon node and add it to the objects node.
     */
    private func setupCannonNode() {
        cannonNode = CannonNode()
        cannonNode.alpha = 0.0
        cannonNode.setScale(0.0)
        cannonNode.position = positions.Cannon
        objectsNode.addChild(cannonNode)
    }
    
    /**
     Create the bullet node.
     
     Note: _The node is not getting added to the objects node automatically._
     */
    private func setupBulletNode() {
        bulletNode = BulletNode()
        bulletNode.position = positions.Cannon
    }
    
    /**
     Adds a pattern of target nodes to the rotation node.
     
     - parameter pattern: The pattern to load
     */
    private func loadPattern(pattern: TargetPattern) {
        // clear out possible current nodes
        currentPatternNodes.removeAll()
        
        // create target nodes for the given pattern
        currentPatternNodes = TargetNodeCreator.create(pattern)
        
        // animate the node loading
        // - add each node with alpa = 0.0 to rotation node
        // - fade in each node with a growing delay
        let waitTime = 0.05
        for (index, arc) in currentPatternNodes.enumerate() {
            arc.alpha = 0.0
            rotationNode.addChild(arc)
            
            let wait = SKAction.waitForDuration(waitTime * Double(index))
            let fadeIn = SKAction.fadeAlphaTo(1.0, duration: ActionDuration)
            arc.runAction(SKAction.sequence([wait, fadeIn]))
        }
        
        // once all nodes are faded in, tell them to start rotating
        let totalWait = SKAction.waitForDuration(waitTime * Double(currentPatternNodes.count + 1))
        runAction(SKAction.sequence([totalWait, SKAction.runBlock {
            self.currentPatternNodes.forEach { $0.shouldRotate = true }
            }]))
    }
    
    //MARK: - Game Loop
    
    /**
    Sets up a new game.
    */
    public func startNewGame() {
        setupNewGame(completion: {
            self.game.startNewGame()
        })
    }
    
    /**
     Performs any scene-specific updates that need to occur before scene actions are evaluated.
     - parameter currentTime: The current system time
     */
    public override func update(currentTime: NSTimeInterval) {
        super.update(currentTime)
        
        // calculate time delta since last update, limit to 30fps
        // TODO: fix calculation, upgrade to 60fps
        dt =  lastUpdateTime > 0 ? currentTime - lastUpdateTime : 0.0
        if dt > 1.0/30.0 {
            dt = 1.0/30.0
        }
        lastUpdateTime = currentTime
        
        // target nodes can be rotating even if the game isn't in playing state
        rotateTargetNodes()
        
        // check if game is running, only continue when it is
        guard isGameRunning else { return }
        
        // perform game tick
        game.tick(dt)
        
        // check if the cannon should be reloaded & move bullets
        reloadBulletIfNeeded()
        moveBullet()
    }
    
    /**
     Move the bullet if needed.
     */
    private func moveBullet() {
        // bullet should be moved if it was shot
        guard bulletNode.bullet.wasShot else { return }
        
        bulletNode.moveBy(CGPoint(x: 0, y: speeds.Bullet), dt: dt)
        
        // remove bullet if it reaches the playing area's bounds without touching a target
        if bulletNode.position.y > positions.ScreenMiddle.y + sizes.PlayingAreaDiameter / 2.0 - bulletNode.size.height / 2.0 {
            bulletNode.removeFromParent()
            
            // end the game if the player hasn't anymore bullets
            if game.bullets == 0 {
                game.endGame()
            }
        }
    }
    
    /**
     Rotate the target nodes.
     */
    private func rotateTargetNodes() {
        // rotate each of the current nodes where shouldRotate is set to true
        for targetNode in currentPatternNodes where targetNode.shouldRotate == true {
            let direction = CGFloat(rotationDirection.rawValue)
            let realSpeed = speeds.Target * game.speedMultiplier
            targetNode.zRotation += CGFloat(dt) * realSpeed * direction
        }
    }
    
    //MARK: - Game Actions
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // handle touches depending on the scene's current state
        // - menu & game over: forward touches to their UI node
        // - playing: shoot bullet
        switch sceneState as SceneState {
        case .Menu: menuNode?.touchesBegan(touches, withEvent: event)
        case .Playing:
            if isGameRunning { shootBullet() }
        case .GameOver: gameOverNode?.touchesBegan(touches, withEvent: event)
        }
    }
    
    /**
     Shoot a bullet
     */
    private func shootBullet() {
        // a bullet can only be shot if the player has at least one bullet left in his magazine
        // and if no other bullet is currently being shot (can only shoot one bullet at a time)
        guard game.bullets > 0 && !bulletNode.bullet.wasShot else { return }
        
        game.shootBullet()
        
        // mark bullet as shot, so it's picked up by the moveBullet routine in the update loop
        bulletNode.bullet.shoot()
    }
    
    /**
     Reload a bullet if needed.
     */
    private func reloadBulletIfNeeded() {
        guard shouldReloadBulletOnNextUpdate else { return }
        shouldReloadBulletOnNextUpdate = false
        
        // reset the bullet's state and position
        bulletNode.bullet.reload()
        bulletNode.position = positions.Cannon
        
        // animate the bullet to make it stick out of the cannon a bit
        let move = SKAction.moveTo(positions.CannonBullet, duration: ActionDuration / 3.0)
        bulletNode.runAction(move)
    }
    
    /**
     Save the score
     - parameter score: score to be saved
     */
    private func saveScore(score: Int) {
        // the score only needs to be saved if it is higher then the currently saved best score
        guard score > Settings.sharedManager.bestScore else { return }
        
        //GameCenterManager.sharedManager.reportScore(score) // TODO: uncomment for prod
        Settings.sharedManager.setBestScore(score)
    }
    
    /**
     Makes the whole screen wiggle.
     */
    private func performWiggleAnimation() {
        let wiggleCount = 3
        let wiggleStepDuration = ActionDuration / Double(wiggleCount)
        let wiggleStepFragmentDuration = wiggleStepDuration / 3.0
        
        var wiggleActionSteps = [SKAction]()
        for _ in 0..<wiggleCount {
            let wiggleAmountX = CGFloat.randomBetween(10, and: 20)
            let wiggleAmountY = CGFloat.randomBetween(10, and: 20)
            
            let wiggleRightAction = SKAction.moveByX(wiggleAmountX, y: wiggleAmountY, duration: wiggleStepFragmentDuration)
            let wiggleLeftAction = SKAction.moveByX(-wiggleAmountX * 2.0, y: -wiggleAmountY * 2.0, duration: wiggleStepFragmentDuration)
            
            let wiggle = SKAction.sequence([wiggleRightAction, wiggleLeftAction, wiggleRightAction])
            
            wiggleActionSteps.append(wiggle)
        }
        
        let sequence = SKAction.sequence(wiggleActionSteps)
        objectsNode.runAction(sequence)
        playingNode?.runAction(sequence)
    }
}

//MARK: - GameDelegate
extension Scene: GameDelegate {
    /**
     Respond to a new game being started
     */
    public func gameDidStart() {
        rotationDirection = .CounterClockwise
        isGameRunning = true
    }
    
    /**
     Respond to the game being ended
     */
    public func gameDidEnd(score: Int) {
        isGameRunning = false
        saveScore(score)
        
        // run the closing animation chain, it's a bit messy and spread around many places, urgh :(
        // [1] make the screen wiggle (performed right below)
        // [2] pop the cannon (performed right below)
        // [3] fade out the target on the rotationnode (performed right below)
        // [4] pop/fade out score label/progress indicator (performed in the playingNode)
        // [5] fade out the playingBackgroundNode (called in the playingNode, performed in the playingBackgroundNode)
        
        performWiggleAnimation()                                    // [1]
        cannonNode.runAction(SKAction.popAction)                    // [2]

        let fadeOut = SKAction.fadeOutWithDuration(ActionDuration)
        for node in rotationNode.children {
            node.runAction(fadeOut)                                 // [3]
        }
        
        playingNode?.close(withTargetState: .GameOver)              // call to [4] & [5]
    }
    
    /**
     Respond to the game advancing to the next stage
     */
    public func gameDidProceedToStage(stage: Int, withPattern pattern: TargetPattern) {
        // check if the collision line node is needed this round
        if game.stageStyle == .Bonus {
            collisionLineNode.removeFromParent()
        } else {
            collisionLineNode.removeFromParent()
            objectsNode.addChild(collisionLineNode)
        }
        
        playingNode?.updatePlayingBackground(forStyle: game.stageStyle)
        
        // load pattern for next stage
        loadPattern(pattern)
    }
    
    /**
     Respond to the game changing its score
     */
    public func gameDidScore(newScore: Int) {
        // inform the playing UI it should update its label text
        playingNode?.updateScoreLabel(withScore: newScore)
    }
    
    /**
     Respond to the game changing its amount of bullets
     */
    public func gameDidChangeAmountOfBullets(byAmount: Int, totalAmount: Int) {
        if byAmount > 0 && totalAmount > 0 {
            shouldReloadBulletOnNextUpdate = true
        }
    }
}

//MARK: - Physics Delegate
extension Scene: SKPhysicsContactDelegate {
    // Respond to a collision
    public func didBeginContact(contact: SKPhysicsContact) {
        // check which two types of entities are involved in the collision
        let checkCollisionForEntityType: (type: EntityType) -> Bool = { (type) in
            let typeValue = type.rawValue
            return contact.bodyA.categoryBitMask == typeValue || contact.bodyB.categoryBitMask == typeValue
        }
        
        let isTargetCollision = checkCollisionForEntityType(type: .Target)
        
        // only need to continue when a target is involved in the collision
        guard isTargetCollision else { return }
        
        let isBulletCollision = checkCollisionForEntityType(type: .Bullet)
        let isMarkerCollision = checkCollisionForEntityType(type: .CollisionMarker)
        
        // target collided with bullet
        // - increase score via game
        // - remove target node
        // - check if stage was cleared
        if isBulletCollision {
            // need to check if bullet was marked as hit already, because this delegate callback will be called more than once
            if !bulletNode.bullet.didHit {
                // mark bullet as hit
                bulletNode.bullet.hit()
                
                // tell the game to increase the scire
                game.increaseScore()
                
                // update playing UI
                if game.stageStyle == .Normal {
                    playingNode?.progressIndicator.advanceProgress()
                }
                
                // get & remove target node
                let targetBody: SKPhysicsBody = contact.bodyA.categoryBitMask == EntityType.Target.rawValue ? contact.bodyA : contact.bodyB
                let targetNode = targetBody.node as? TargetNode
                targetNode?.removeFromParent()
                
                let index = currentPatternNodes.indexOf(targetBody.node as! TargetNode)!
                currentPatternNodes.removeAtIndex(index)
                
                // if no target nodes are left, the current stage was cleared -> advance to next one
                if currentPatternNodes.count == 0 {
                    // update playing UI if needed
                    if game.stageStyle == .Bonus {
                        playingNode?.progressIndicator.resetProgress()
                    }
                    
                    game.nextStage()
                }
            }
        }
            // target collided with marker
            // - flip rotation direction
            // - reset collision line node
        else if isMarkerCollision {
            let markerBody: SKPhysicsBody = contact.bodyA.categoryBitMask == EntityType.CollisionMarker.rawValue ? contact.bodyA : contact.bodyB
            
            // had problems with the collision being called out multiple times, so I
            // remove the physicsBody from it to prevent collision detection and add
            // it back after a small delay. TODO: tweak / find better solution
            defer {
                collisionLineNode.physicsBody = nil
            }
            
            if collisionLineNode.physicsBody != nil {
                rotationDirection.flip()
                
                let wait = SKAction.waitForDuration(0.2)
                let block = SKAction.runBlock {
                    self.collisionLineNode.physicsBody = markerBody
                }
                runAction(SKAction.sequence([wait, block]))
            }
        }
    }
}

extension Scene: SceneTransitionDelegate {
    //MARK: - Scene Transitioning
    
    /**
    Swich to another state
    - parameter state: The desired state
    */
    private func switchToState(state: SceneState) {
        guard state != sceneState else { return }
        
        func switchToMenuState() {
            sceneState = .Menu
            
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
    
    /**
     Respond to the scene finishing a transition between states.
     - parameter fromState: The previous state
     - parameter toState: The new state
     */
    public func completedTransitionFromState(fromState: SceneState, andShouldNowSwitchToState toState: SceneState) {
        defer {
            switchToState(toState)
        }
        
        // clean up
        switch fromState {
        case .Menu:
            menuNode?.removeFromParent()
            menuNode = nil
        case .Playing:
            objectsNode.removeAllChildren()
            rotationNode.removeAllChildren()
            objectsNode.addChild(rotationNode)
            playingNode?.removeFromParent()
            playingNode = nil
        case .GameOver:
            gameOverNode?.removeFromParent()
            gameOverNode = nil
        }
    }
}
//
//  GameScene.swift
//  CatNap
//
//  Created by Matthew J. Perkins on 10/18/17.
//  Copyright © 2017 Matthew J. Perkins. All rights reserved.
//

import SpriteKit



struct PhysicsCategory {
    static let None: UInt32 = 0
    static let Cat: UInt32 = 0b1
    static let Block: UInt32 = 0b10
    static let Bed: UInt32 = 0b100
    static let Edge: UInt32 = 0b1000
    static let Label: UInt32 = 0b10000
    
}

protocol  EventListenerNode {
    func didMoveToScene()
}

protocol InteractiveNode {
    func interact()
}


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bedNode: BedNode!
    var catNode: CatNode!
    var playable = true
    
    func inGameMessage(text: String) {
        let message = MessageNode(message: text)
        message.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(message)
    }
    
    func newGame() {
        let scene = GameScene(fileNamed: "GameScene")
        scene!.scaleMode = scaleMode
        view!.presentScene(scene)
    }
    
    func lose() {
        playable = false
        SKTAudio.sharedInstance().pauseBackgroundMusic()
        SKTAudio.sharedInstance().playSoundEffect("lose.mp3")
        
        inGameMessage(text: "Try again...")
        
        run(SKAction.afterDelay(5, runBlock: newGame))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if !playable {
            return
        }
        
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == PhysicsCategory.Cat | PhysicsCategory.Bed   {
            print("Success")
        } else if collision == PhysicsCategory.Cat | PhysicsCategory.Edge {
            print("Fail")
            lose()
        }
    }
    
    override func didMove(to view: SKView) {
        //Calculate playable margin
        
        // Calculate playable margin
        
        let maxAspectRatio: CGFloat = 16.0/9.0
        let maxAspectRatioHeight = size.width / maxAspectRatio
        let playableMargin: CGFloat = (size.height
            - maxAspectRatioHeight)/2
        
        let playableRect = CGRect(x: 0, y: playableMargin,
                                  width: size.width, height: size.height-playableMargin*2)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: playableRect)
        
        enumerateChildNodes(withName: "//*", using: { node, _ in
            if let eventListenerNode = node as? EventListenerNode {
                eventListenerNode.didMoveToScene()
            }
        })
        
        bedNode = childNode(withName: "bed") as! BedNode
        catNode = childNode(withName: "//cat_body") as! CatNode
        catNode!.isPaused = false
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: playableRect)
        physicsWorld.contactDelegate = self
        physicsBody!.categoryBitMask = PhysicsCategory.Edge
       // SKTAudio.sharedInstance().playBackgroundMusic("backgroundMusic.mp3")
    }
}

//
//  CatNode.swift
//  CatNap
//
//  Created by Matthew J. Perkins on 10/20/17.
//  Copyright © 2017 Matthew J. Perkins. All rights reserved.
//

import SpriteKit

class CatNode: SKSpriteNode, EventListenerNode {
    func didMoveToScene() {
        print("cat added to scene")
        let catBodyTexture = SKTexture(imageNamed: "cat_body_outline")
        parent!.physicsBody = SKPhysicsBody(texture: catBodyTexture, size: catBodyTexture.size())
        parent!.physicsBody!.categoryBitMask = PhysicsCategory.Cat
        parent!.physicsBody!.collisionBitMask = PhysicsCategory.Block | PhysicsCategory.Edge
        parent!.physicsBody!.contactTestBitMask = PhysicsCategory.Bed | PhysicsCategory.Edge
       
        
    }
    
    func wakeUp() {
        
        
        for child in children {
            child.removeFromParent()
        }
        texture = nil
        color = SKColor.clear
        
        let catAwake = SKSpriteNode(fileNamed: "CatWakeUp")!.childNode(withName: "cat_awake")!
        
        catAwake.move(toParent: self)
        catAwake.position = CGPoint(x: -30, y: 100)
        catAwake.isPaused = false
    }
    
    func curlAt(scenePoint: CGPoint) {
        parent!.physicsBody = nil
        
        for child in children {
            child.removeFromParent()
        }
        
        texture = nil
        color = SKColor.clear
        
        let catCurl = SKSpriteNode(fileNamed: "CatCurl")!.childNode(withName: "cat_curl")!
        catCurl.move(toParent: self)
        catCurl.position = CGPoint(x: -30, y: 100)
        catCurl.isPaused = false
        
        
        var localPoint = parent!.convert(scenePoint, from: scene!)
        localPoint.y += frame.size.height/3
        
        run(SKAction.group([SKAction.move(to: localPoint, duration: 0.66), SKAction.rotate(toAngle: -parent!.zRotation, duration: 0.5)]))
    }
}

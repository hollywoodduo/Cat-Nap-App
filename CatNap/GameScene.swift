//
//  GameScene.swift
//  CatNap
//
//  Created by Matthew J. Perkins on 10/18/17.
//  Copyright © 2017 Matthew J. Perkins. All rights reserved.
//

import SpriteKit

protocol  EventListenerNode {
    func didMoveToScene()
}


class GameScene: SKScene {
    
    var bedNode: BedNode!
    var catNode: CatNode!
    
    override func didMove(to view: SKView) {
        //Calculate playable margin
        
        let maxAspectRatio: CGFloat = 16.0/9/0
        let maxAspectRationHeight = size.width / maxAspectRatio
        let playableMargin: CGFloat = (size.height - maxAspectRatio) / 2
        let playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: size.height - playableMargin*2)
        physicsBody = SKPhysicsBody(edgeLoopFrom: playableRect)
        
        enumerateChildNodes(withName: "//*", using: { node, _ in
            if let eventListenerNode = node as? EventListenerNode {
                eventListenerNode.didMoveToScene()
            }
        })
        

        
        bedNode.setScale(1.5)
        catNode.setScale(1.5)
    }
}

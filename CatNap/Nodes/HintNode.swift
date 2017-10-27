//
//  HintNode.swift
//  CatNap
//
//  Created by Matthew J. Perkins on 10/27/17.
//  Copyright © 2017 Matthew J. Perkins. All rights reserved.
//

import SpriteKit

class HintNode: SKSpriteNode, EventListenerNode, InteractiveNode {
    
    private var colors = [SKColor.red, SKColor.yellow, SKColor.orange, SKColor.green, SKColor.blue]
    private var shape: SKShapeNode!
    
    var arrowPath: CGPath = {
        let bezierPath = UIBezierPath()
        
        bezierPath.move(to: CGPoint(x: 0.5, y: 65.69))
        bezierPath.addLine(to: CGPoint(x: 74.99, y: 1.5))
        bezierPath.addLine(to: CGPoint(x: 74.99, y: 38.66))
        bezierPath.addLine(to: CGPoint(x: 257.5, y: 38.66))
        bezierPath.addLine(to: CGPoint(x: 257.5, y: 92.72))
        bezierPath.addLine(to: CGPoint(x: 74.99, y: 92.72))
        bezierPath.addLine(to: CGPoint(x: 74.99, y: 126.5))
        bezierPath.addLine(to: CGPoint(x: 0.5, y: 65.69))
        bezierPath.close()
        
        return bezierPath.cgPath
    }()
    
    func didMoveToScene() {
        color = SKColor.clear
        
        shape = SKShapeNode(path: arrowPath)
        shape.strokeColor = SKColor.gray
        shape.lineWidth = 4
        shape.fillColor = SKColor.green
        addChild(shape)
        
        shape.fillTexture = SKTexture(imageNamed: "wood_tinted")
        shape.alpha = 0.8
        
        let move = SKAction.moveBy(x: -40, y: 0, duration: 1.0)
        let bounce = SKAction.sequence([
            move, move.reversed()
            ])
        let bounceAction = SKAction.repeat(bounce, count: 3)
        
        shape.run(bounceAction, completion: {
            self.removeFromParent()
        })
        
        isUserInteractionEnabled = true
    }
    
    func interact() {
        shape.fillColor = colors[Int.random(min: 0, max: colors.count - 1)]
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        interact()
    }
    
}


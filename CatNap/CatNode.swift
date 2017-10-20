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
    }
}

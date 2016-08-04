//
//  WhackSlot.swift
//  Project14
//
//  Created by Jeffrey Eng on 8/4/16.
//  Copyright © 2016 Jeffrey Eng. All rights reserved.
//

import UIKit
import SpriteKit

class WhackSlot: SKNode {
    
    func configureAtPosition(pos: CGPoint) {
        position = pos
        
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
    }
    
}

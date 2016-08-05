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
    
    var visible: Bool = false
    var isHit: Bool = false
    
    var charNode: SKSpriteNode!
    
    func configureAtPosition(pos: CGPoint) {
        position = pos
        
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNode.addChild(charNode)
        
        addChild(cropNode)
    }
    
    func show(hideTime hideTime: Double) {
        if visible { return }
        
        charNode.runAction(SKAction.moveByX(0, y: 80, duration: 0.05))
        visible = true
        isHit = false
        
        if RandomInt(min: 0, max: 2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        
        RunAfterDelay(hideTime * 3.5) { [unowned self] in
            self.hide()
        }
    }
    
    func hide() {
        // conditional to exit out of function if visible property isn't true
        if !visible { return }
        // instructs character node to move down to hide
        charNode.runAction(SKAction.moveByX(0, y: -80, duration: 0.05))
        // set the visible property to false
        visible = false
    }
    
    func hit() {
        isHit = true
        
        let delay = SKAction.waitForDuration(0.25)
        let hide =  SKAction.moveByX(0, y: -80, duration: 0.5)
        let notVisible = SKAction.runBlock { [unowned self] in self.visible = false }
        charNode.runAction(SKAction.sequence([delay, hide, notVisible]))
    }
}

//
//  GameScene.swift
//  Project14
//
//  Created by Jeffrey Eng on 8/3/16.
//  Copyright (c) 2016 Jeffrey Eng. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var slots = [WhackSlot]()
    
    var gameScore: SKLabelNode!
    var score: Int = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    var popupTime = 0.85
    
    override func didMoveToView(view: SKView) {
        
        // Adds a background as a node to the Game Scene
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .Replace
        background.zPosition = -1
        addChild(background)
        
        // Adds the score label to the Game Scene
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .Left
        addChild(gameScore)
        
        // Create rows of slots with calculated x and y coordinates
        for i in 0..<5 { createSlotAt(CGPoint(x: 100 + (i * 170), y: 410)) }
        for i in 0..<4 { createSlotAt(CGPoint(x: 180 + (i * 170), y: 320)) }
        for i in 0..<5 { createSlotAt(CGPoint(x: 100 + (i * 170), y: 230)) }
        for i in 0..<4 { createSlotAt(CGPoint(x: 180 + (i * 170), y: 140)) }
        
        RunAfterDelay(1) { [unowned self] in
            self.createEnemy()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            let nodes = nodesAtPoint(location)
            
            for node in nodes {
                if node.name == "charFriend" {
                    let whackSlot = node.parent!.parent as! WhackSlot
                    if !whackSlot.visible { continue }
                    if whackSlot.isHit { continue }
                    // call the hit method to make the penguin hide itself
                    whackSlot.hit()
                    // subtract 5 pts from score
                    score -= 5
                    // run action that plays a "bad hit" sound
                    runAction(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion: false))
                } else if node.name == "charEnemy" {
                    let whackSlot = node.parent!.parent as! WhackSlot
                    if !whackSlot.visible { continue }
                    if whackSlot.isHit { continue }
                    
                    whackSlot.charNode.xScale = 0.85
                    whackSlot.charNode.yScale = 0.85
                    
                    whackSlot.hit()
                    score += 1
                    
                    runAction(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
                }
            }
        }
        
    }
   
//    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
//    }
    
    func createSlotAt(pos: CGPoint) {
        // Create instance of WhackSlot class
        let slot = WhackSlot()
        // Call the configureAtPosition method for this instance of WhackSlot
        slot.configureAtPosition(pos)
        // Insert the WhackSlot object into the Game Scene
        addChild(slot)
        // Store this object in the slots array that stores WhackSlot objects
        slots.append(slot)
    }
    
    func createEnemy() {
        popupTime *= 0.991
        
        slots = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(slots) as! [WhackSlot]
        slots[0].show(hideTime: popupTime)
        
        let randomInteger = RandomInt(min: 0, max: 12)
        if randomInteger > 4 { slots[1].show(hideTime: popupTime) }
        if randomInteger > 8 { slots[2].show(hideTime: popupTime) }
        if randomInteger > 10 { slots[3].show(hideTime: popupTime) }
        if randomInteger > 11 { slots[4].show(hideTime: popupTime) }

        let minDelay = popupTime / 2.0
        let maxDelay = popupTime * 2
        
        RunAfterDelay(RandomDouble(min: minDelay, max: maxDelay)) { [unowned self] in
            self.createEnemy()
        }
    }
    
    
    
    
    
    
    
}

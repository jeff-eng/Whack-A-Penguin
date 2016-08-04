//
//  GameScene.swift
//  Project14
//
//  Created by Jeffrey Eng on 8/3/16.
//  Copyright (c) 2016 Jeffrey Eng. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var slots = [WhackSlot]()
    
    var gameScore: SKLabelNode!
    var score: Int = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    
    override func didMoveToView(view: SKView) {
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .Replace
        background.zPosition = -1
        addChild(background)
        
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .Left
        addChild(gameScore)
        
        for i in 0..<5 { createSlotAt(CGPoint(x: 100 + (i * 170), y: 410)) }
        for i in 0..<4 { createSlotAt(CGPoint(x: 180 + (i * 170), y: 320)) }
        for i in 0..<5 { createSlotAt(CGPoint(x: 100 + (i * 170), y: 230)) }
        for i in 0..<4 { createSlotAt(CGPoint(x: 180 + (i * 170), y: 140)) }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
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
}

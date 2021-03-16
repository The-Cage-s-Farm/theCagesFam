//
//  HallwayScene.swift
//  CagesFarm
//
//  Created by Gilberto Magno on 3/16/21.
//

import Foundation
import SpriteKit
import GameplayKit

class HallwayScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    
    
    private var tony = Characters(characterType: .tony)
    private var dialogBox = DialogueBox()
    private var backGround = SKSpriteNode(imageNamed: "TapeteQuadrado")
    
    override func sceneDidLoad() {
        
        
        self.addChild(tony)
        self.addChild(backGround)
        backGround.zPosition = -1
        
        self.lastUpdateTime = 0
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        // Create shape node to use during mouse interaction
        
        
    }
     override func didChangeSize(_ oldSize: CGSize) {
        tony.size = CGSize(width: 100, height: 100)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
        if !tony.isWalking {
            let isBackground = atPoint(pos)
            if !(isBackground is InteractableObjects) {
                    tony.walk(posx: pos.x)
                }
            }
        

        guard let objectInTouch = atPoint(pos) as? InteractableObjects else {return}
        if objectInTouch.isCloseInteract {
            
            //MUDAR PRA TORNAR MAIS AUTOMATICO PRA TODOS OBJETOS
            if dialogBox.parent == nil {
                let actualAnswerID = objectInTouch.actualAnswer
                self.addChild(dialogBox)
                self.dialogBox.nextText(answer: objectInTouch.answers[actualAnswerID])
                objectInTouch.nextDialogue()
            }else {
                
                self.dialogBox.removeFromParent()
            }
        
            
        }else{

            
            
        }
        
       
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
            
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}

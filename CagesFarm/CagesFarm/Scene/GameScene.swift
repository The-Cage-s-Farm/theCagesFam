//
//  GameScene.swift
//  CagesFarm
//
//  Created by Gilberto Magno on 3/8/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    
    
    private var tony = Characters(characterType: .tony)
    private var quadro = InteractableObjects(objectType: .quadro)
    private var bau = InteractableObjects(objectType: .bau)
    private var cama = InteractableObjects(objectType: .cama)
    private var comoda = InteractableObjects(objectType: .comoda)
    private var interruptor = InteractableObjects(objectType: .interruptor)
    private var tapete = InteractableObjects(objectType: .tapete)
    private var dialogBox = DialogueBox()
    private var backGround = SKSpriteNode(imageNamed: "QuartoBackground")
    
    override func sceneDidLoad() {
        
        
        self.addChild(tony)
        self.addChild(quadro)
        self.addChild(backGround)
        self.addChild(bau)
        self.addChild(comoda)
        self.addChild(interruptor)
        self.addChild(tapete)
        self.addChild(cama)
        backGround.zPosition = -1
        tony.zPosition = +1
        self.lastUpdateTime = 0
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        // Create shape node to use during mouse interaction
        
        
    }
     override func didChangeSize(_ oldSize: CGSize) {
        tony.size = CGSize(width: 100, height: 100)
        quadro.size = CGSize(width: 200, height: 200)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
        //TRANSICAO DE CENA, FALTA COLOCAR A PORTA PARA ISSO OCORRER COM ELA
//        let transition:SKTransition = SKTransition.fade(withDuration: 1)
//        let scene:SKScene = HallwayScene(size: UIScreen.main.bounds.size)
//        scene.anchorPoint = .init(x: 0.5, y: 0.5)
//        self.view?.presentScene(scene, transition: transition)
        //
        
        

        
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
        quadro.microInteraction(player: tony)
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}

//
//  GameScene.swift
//  CagesFarm
//
//  Created by Gilberto Magno on 3/8/21.
//

import SpriteKit
import GameplayKit

//swiftlint:disable identifier_name unused_optional_binding
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
    private var quadroPerspectiva = InteractableObjects(objectType: .quadroPerspectiva)
    private var dialogBox = DialogueBox()
    private var backGround = SKSpriteNode(imageNamed: "QuartoBackground")
    private var inventory = Inventory(items: [])
    
    override func sceneDidLoad() {
        self.scaleMode = .aspectFit
        self.addChild(tony)
        self.addChild(quadro)
        self.addChild(backGround)
        self.addChild(bau)
        self.addChild(comoda)
        self.addChild(interruptor)
        self.addChild(tapete)
        self.addChild(cama)
        self.addChild(quadroPerspectiva)
        //   self.addChild(inventory)
        backGround.zPosition = -1
        tony.zPosition = +1
        dialogBox.zPosition = +1
        self.lastUpdateTime = 0
    }
    override func didChangeSize(_ oldSize: CGSize) {
        quadro.setScale(1)
        quadroPerspectiva.setScale(1)
        comoda.setScale(0.45)
        
        // Positions

        tony.position = CGPoint(x: 250, y: -60)
        cama.position = CGPoint(x: -240, y: -100)
        cama.xScale = -0.9
        
        quadro.position = CGPoint(x: 120, y: 80)

        tapete.position = CGPoint(x: -25, y: -90)
        tapete.size = CGSize(width: 175, height: 155)
        
        comoda.position = CGPoint(x: 120, y: -20)
        //  bau.position = CGPoint(x: -230, y: -100)
        
        quadroPerspectiva.position = CGPoint(x: -250, y: 45)
        // quadroPerspectiva.xScale = -1
        interruptor.position = CGPoint(x: 240, y: 10)
        bau.position = CGPoint(x: -150, y: -43)
        // interruptor.size = CGSize(width: 200, height: 200)
    }
    
    func interactionObject(pos: CGPoint) {
        
        guard let objectInTouch = atPoint(pos) as? InteractableObjects else {
            if let _ = atPoint(pos) as? DialogueBox {
            tony.isWalking = false
            self.dialogBox.removeFromParent()
            }
            
            return
        }
        
        if objectInTouch.objectName == "Baú" {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = PuzzleScene(size: UIScreen.main.bounds.size)
            scene.anchorPoint = .init(x: 0.5, y: 0.5)
            self.view?.presentScene(scene, transition: transition)
        }
        
        if objectInTouch.isCloseInteract {
            //MUDAR PRA TORNAR MAIS AUTOMATICO PRA TODOS OBJETOS
            if dialogBox.parent == nil {
                let actualAnswerID = objectInTouch.actualAnswer
                self.addChild(dialogBox)
                self.dialogBox.nextText(answer: objectInTouch.answers[actualAnswerID])
                tony.isWalking = true
                objectInTouch.nextDialogue()
            }
        }
    }
    
    func makeMCWalk(pos: CGPoint) {
        //INVERTER POSICAO DEPENDENDO DE ONDE ANDA AS
        if !tony.isWalking && pos.x < tony.frame.minX {
            tony.xScale = -1
        } else if !tony.isWalking && pos.x >= tony.frame.minX {
            tony.xScale = +1
        }
        if !tony.isWalking {
            let isBackground = atPoint(pos)
            if !(isBackground is InteractableObjects) {
                tony.walk(posx: pos.x)
            }
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
        //TRANSICAO DE CENA, FALTA COLOCAR A PORTA PARA ISSO OCORRER COM ELA
        //        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        //        let scene:SKScene = HallwayScene(size: UIScreen.main.bounds.size)
        //        scene.anchorPoint = .init(x: 0.5, y: 0.5)
        //        self.view?.presentScene(scene, transition: transition)
        
        makeMCWalk(pos: pos)
        interactionObject(pos: pos)
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
        interruptor.microInteraction(player: tony)
        quadroPerspectiva.microInteraction(player: tony)
        tapete.microInteraction(player: tony)
        cama.microInteraction(player: tony)
        comoda.microInteraction(player: tony)
        bau.microInteraction(player: tony)
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}

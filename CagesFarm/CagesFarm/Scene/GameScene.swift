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
    private var quadroPerspectiva = InteractableObjects(objectType: .quadroPerspectiva)
    private var dialogBox = DialogueBox()
    private var backGround = SKSpriteNode(imageNamed: "QuartoBackground")
    private var xRatio = UIScreen.aspectRatioX
    private var yRatio = UIScreen.aspectRatioY
    
    override func sceneDidLoad() {
        print(xRatio)
        print(yRatio)
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
        backGround.zPosition = -1
        tony.zPosition = +1
        dialogBox.zPosition = +1
        self.lastUpdateTime = 0
    }
     override func didChangeSize(_ oldSize: CGSize) {
        quadro.setScale(1*yRatio)
        quadroPerspectiva.setScale(1*yRatio)
        comoda.setScale(0.45*yRatio)
        
        //Positions
        tony.position = CGPoint(x:  xRatio*250, y: yRatio*(-60))
        cama.position = CGPoint(x: -230*xRatio, y: -100*yRatio)
        cama.xScale = -1

        quadro.position = CGPoint(x: 120*xRatio, y: 80*yRatio)


        tapete.position = CGPoint(x: -25*xRatio, y: -90*yRatio)
        tapete.size = CGSize(width: 175*xRatio, height: 155*yRatio)


        comoda.position = CGPoint(x: 120*xRatio, y: -20*yRatio)


        bau.position = CGPoint(x: -230*xRatio, y: -100*yRatio)

        quadroPerspectiva.position = CGPoint(x: -250, y: 45)
       // quadroPerspectiva.xScale = -1
        interruptor.position = CGPoint(x: 240, y: 10)
       // interruptor.size = CGSize(width: 200, height: 200)

        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
        //TRANSICAO DE CENA, FALTA COLOCAR A PORTA PARA ISSO OCORRER COM ELA
//        let transition:SKTransition = SKTransition.fade(withDuration: 1)
//        let scene:SKScene = PuzzleScene(size: UIScreen.main.bounds.size)
//        scene.anchorPoint = .init(x: 0.5, y: 0.5)
//        self.view?.presentScene(scene, transition: transition)
        //

        //INVERTER POSICAO DEPENDENDO DE ONDE ANDA AS
        if !tony.isWalking && pos.x < tony.frame.minX {
            tony.xScale = -1
        }else if !tony.isWalking && pos.x >= tony.frame.minX {
            tony.xScale = +1
        }
        

        
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
                tony.isWalking = true
                objectInTouch.nextDialogue()
            }else {
                tony.isWalking = false
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

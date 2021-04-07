//
//  GameScene.swift
//  CagesFarm
//
//  Created by Gilberto Magno on 3/8/21.
//

import SpriteKit
import GameplayKit
import AVFoundation

// swiftlint:disable identifier_name unused_optional_binding
class GameScene: SKScene, DialogueBoxDelegate {

    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()

    var backgroundSound: AVAudioPlayer?
    
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
    var inventory = Inventory(items: [])
    private var lastInteraction: LastInteraction?

    override func sceneDidLoad() {
        SceneCoordinator.coordinator.gameScene = self
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
        self.addChild(inventory)
        dialogBox.delegate = self
        backGround.zPosition = -1
        tony.zPosition = +1
        dialogBox.zPosition = +1

        // let path = Bundle.main.path(forResource: "Mysterious.wav", ofType:nil)!
        //let url = URL(fileURLWithPath: path)
        let data = NSDataAsset(name: "Mysterious")!.data

        do {
            backgroundSound = try AVAudioPlayer(data: data)
            backgroundSound?.numberOfLoops = -1
            backgroundSound?.play()
        } catch {
            //Error("Can not read sound.")
        }

    }

    override func didChangeSize(_ oldSize: CGSize) {
        quadro.setScale(1)
        quadroPerspectiva.setScale(1)
        comoda.setScale(0.45)

        // Positions
        tony.position = CGPoint(x: 250, y: -35)
        tony.size = CGSize(width: 120, height: 120)
        cama.position = CGPoint(x: -255, y: -115)
        cama.setScale(0.8)
        quadro.position = CGPoint(x: 120, y: 80)
        tapete.position = CGPoint(x: -25, y: -90)
        tapete.size = CGSize(width: 175, height: 155)
        comoda.position = CGPoint(x: 120, y: -20)
        quadroPerspectiva.position = CGPoint(x: -250, y: 45)
        quadroPerspectiva.xScale = -1
        interruptor.position = CGPoint(x: 240, y: 10)
        bau.position = CGPoint(x: -150, y: -43)
    }
    
    func interactionObject(pos: CGPoint) {
        guard let objectInTouch = atPoint(pos) as? InteractableObjects else {
            if let _ = atPoint(pos) as? DialogueBox {
                tony.isWalking = false
                self.dialogBox.removeFromParent()
            }
            
            return
        }
        
        if objectInTouch.objectName == "Bau" {
            if SceneCoordinator.coordinator.entryPuzzleScenes["colors"]! {
                let transition: SKTransition = SKTransition.fade(withDuration: 1)
                let scene: SKScene = PuzzleScene(size: UIScreen.main.bounds.size)
                scene.anchorPoint = .init(x: 0.5, y: 0.5)
                backgroundSound?.stop()
                self.view?.presentScene(scene, transition: transition)
            }
        }

        if  objectInTouch.objectType == .comoda {
            if let shouldShowPuzzle = SceneCoordinator.coordinator.shouldShouldKeyboardPuzzle {
                if shouldShowPuzzle {
                    objectInTouch.actualAnswer = 2
                } else {
                    objectInTouch.actualAnswer = 3
                }

            }
        }
        
        if objectInTouch.isCloseInteract {
            // MUDAR PRA TORNAR MAIS AUTOMATICO PRA TODOS OBJETOS
            if dialogBox.parent == nil {
                let actualAnswerID = objectInTouch.actualAnswer
                self.addChild(dialogBox)
                guard let answer = objectInTouch.answers else {return}
                self.dialogBox.nextText(answer: answer[actualAnswerID])
                tony.isWalking = true
                lastInteraction = nil
                lastInteraction = LastInteraction(objectType: objectInTouch,
                                                  currentAnswer: objectInTouch.actualAnswer)
                if objectInTouch.canProceedInteraction {
                    objectInTouch.nextDialogue()
                }
            }
        }
    }
    func makeMCWalk(pos: CGPoint) {
        // INVERTER POSICAO DEPENDENDO DE ONDE ANDA AS
        let itIsInventory = atPoint(pos)
        if !(itIsInventory is Inventory) && !(itIsInventory is SKShapeNode) {
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
    }

    func didShowDialog(currentDialog: Int, object: InteractableObjects) {
        switch object.objectType {
        case .comoda:
            handleComodaTouch(currentDialog: currentDialog, comoda: object)
        default:
            break
        }
    }

    func didFinishShowingText() {
        if let lastInteraction = lastInteraction {
            didShowDialog(currentDialog: lastInteraction.currentAnswer,
                          object: lastInteraction.objectType)
        }
    }

    private func handleComodaTouch(currentDialog: Int, comoda: InteractableObjects) {
        let coordinator = SceneCoordinator.coordinator
        if currentDialog == 1 {
            if coordinator.shouldAddKnife {
                coordinator.addItemToInventory(item: ItemType.knife.rawValue)
                coordinator.shouldAddKnife = false
            }
        }

        if currentDialog == 2 && coordinator.shouldShouldKeyboardPuzzle == nil {
            coordinator.shouldShouldKeyboardPuzzle = true
        }
        
        comoda.canProceedInteraction = !(coordinator.shouldShouldKeyboardPuzzle ?? false)

        if coordinator.shouldShouldKeyboardPuzzle ?? false {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = DresserKeyboard(size: UIScreen.main.bounds.size)
            scene.anchorPoint = .init(x: 0.5, y: 0.5)
            self.view?.presentScene(scene, transition: transition)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
        // TRANSICAO DE CENA, FALTA COLOCAR A PORTA PARA ISSO OCORRER COM ELA
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

//
//  HallScene.swift
//  CagesFarm
//
//  Created by Beatriz Carlos on 08/04/21.
//

import SpriteKit
import GameplayKit

//swiftlint:disable unused_optional_binding
class HallScene: SKScene, DialogueBoxDelegate, ImageRetriever {
    var closeCallbackToMenu: (() -> Void)?
    private var dialogBox = DialogueBox()
    private var lastInteraction: LastInteraction?
    
    private lazy var background: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "hall")
        node.zPosition = -1
        return node
    }()
    
    private var tony : Characters = {
        let node = Characters(characterType: .tony)
        node.zPosition = +2
        node.position = CGPoint(x: 250, y: -35)
        node.size = CGSize(width: 120, height: 120)
        return node
    }()
    
    lazy var doorOne: InteractableObjects  = {
        let node = InteractableObjects(objectType: .doorOne)
        node.setScale(0.65)
        node.position = CGPoint(x: -360, y: 18)
        node.zPosition = +1
        return node
    }()
    
    lazy var doorTwo: InteractableObjects  = {
        let node = InteractableObjects(objectType: .doorTwo)
        node.setScale(0.65)
        node.position = CGPoint(x: -25, y: 18)
        node.zPosition = +1
        return node
    }()
    
    lazy var doorThree: InteractableObjects  = {
        let node = InteractableObjects(objectType: .doorThree)
        node.setScale(0.65)
        node.position = CGPoint(x: 320, y: 18)
        node.zPosition = +1
        return node
    }()
    
    override func sceneDidLoad() {
        tony.isWalking = false
        setScene()
    }
    
    private func setScene() {
        self.scaleMode = .aspectFit
        addChild()
        dialogBox.delegate = self
        dialogBox.zPosition = +2
    }
    
    private func addChild() {
        self.addChild(tony)
        self.addChild(background)
        self.addChild(doorOne)
        self.addChild(doorTwo)
        self.addChild(doorThree)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        print(tony.isWalking)
        self.makeMCWalk(pos: pos)
        
        interactionObject(pos: pos)
        dialogBox.zPosition = +2
    }
    
    func interactionObject(pos: CGPoint) {
        guard let objectInTouch = atPoint(pos) as? InteractableObjects else {
            if let _ = atPoint(pos) as? DialogueBox {
                tony.isWalking = false
                self.dialogBox.removeFromParent()
            }
            return
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

            if  objectInTouch.objectType == .doorThree {
                let otherWait = SKAction.wait(forDuration: 2)
                let fadOut = SKAction.fadeOut(withDuration: 2)
                let sequence = SKAction.sequence([otherWait, fadOut])
                
                self.run(sequence) {
                    self.closeCallbackToMenu?()
                }
            }
        }
    }
    
    private func makeMCWalk(pos: CGPoint) {
        let itIsInventory = atPoint(pos)
        if !(itIsInventory is Inventory) && !(itIsInventory is SKShapeNode) {
            if !tony.isWalking && pos.x < tony.frame.minX {
                tony.xScale = -1
            } else if !tony.isWalking && pos.x >= tony.frame.minX {
                tony.xScale = +1
            }
            if !tony.isWalking {
                tony.walk(posx: pos.x)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    func didFinishShowingText() {}
    
    override func update(_ currentTime: TimeInterval) {
        doorOne.microInteraction(player: tony)
        doorTwo.microInteraction(player: tony)
        doorThree.microInteraction(player: tony)
    }
}

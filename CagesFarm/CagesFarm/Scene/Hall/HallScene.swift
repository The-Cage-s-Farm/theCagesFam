//
//  HallScene.swift
//  CagesFarm
//
//  Created by Beatriz Carlos on 08/04/21.
//

import SpriteKit
import GameplayKit

class HallScene: SKScene, DialogueBoxDelegate {
    private var dialogBox = DialogueBox()
    
    private var tony : Characters = {
        let node = Characters(characterType: .tony)
        node.zPosition = +1
        node.position = CGPoint(x: 250, y: -35)
        node.size = CGSize(width: 120, height: 120)
        return node
    }()
    
    private lazy var background: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "hall")
        node.zPosition = -1
        return node
    }()
    
    lazy var doorOne: SKSpriteNode  = {
        let node = SKSpriteNode(imageNamed: "door")
        node.setScale(0.5)
        node.position = CGPoint(x: -350, y: 0)
        node.zPosition = +1
        return node
    }()

    override func sceneDidLoad() {
        setScene()
    }
    
    private func setScene() {
        self.scaleMode = .aspectFit
        addChild()
        dialogBox.delegate = self
    }
    
    private func addChild() {
        self.addChild(tony)
        self.addChild(background)
        self.addChild(doorOne)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        self.makeMCWalk(pos: pos)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    func didFinishShowingText() {
    }
    
    private func makeMCWalk(pos: CGPoint) {
        // INVERTER POSICAO DEPENDENDO DE ONDE ANDA AS
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
}

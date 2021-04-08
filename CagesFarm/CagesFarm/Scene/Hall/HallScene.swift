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
    }
    
    func touchDown(atPoint pos : CGPoint) {
        print("teste")
        SceneCoordinator.coordinator.gameScene?.makeMCWalk(pos: pos)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    func didFinishShowingText() {
    }
}

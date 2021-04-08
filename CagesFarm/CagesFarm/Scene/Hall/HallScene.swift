//
//  HallScene.swift
//  CagesFarm
//
//  Created by Beatriz Carlos on 08/04/21.
//

import SpriteKit
import GameplayKit

class HallScene: SKScene, DialogueBoxDelegate {
    private var background = SKSpriteNode(imageNamed: "hall")
    private var dialogBox = DialogueBox()

    override func sceneDidLoad() {
        self.addChild(background)
        background.zPosition = -1
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    func didFinishShowingText() {
    }
}

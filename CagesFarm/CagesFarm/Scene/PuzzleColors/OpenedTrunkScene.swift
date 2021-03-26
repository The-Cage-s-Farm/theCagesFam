//
//  OpenedTrunkScene.swift
//  CagesFarm
//
//  Created by José Mateus Azevedo on 26/03/21.
//

import Foundation
import SpriteKit
import GameplayKit

class OpenedTrunkScene: SKScene {

    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()

    let backButton = SKLabelNode()
    let trunk = SKSpriteNode()
    let deed = SKSpriteNode()

    override func sceneDidLoad() {
        setsComponents()
    }

    private func setsComponents() {
        backButton.fontName = "Dogica"
        backButton.text = "Voltar"
        backButton.horizontalAlignmentMode = .left
        backButton.position = CGPoint(x: -400, y: 130)
        addChild(backButton)

        trunk.texture = SKTexture(imageNamed: "Bau")
        trunk.position = CGPoint(x: 0, y: 0)
        trunk.size = CGSize(width: 500, height: 400)
        addChild(trunk)

        deed.texture =  SKTexture(imageNamed: "Quadro")
        deed.position = CGPoint(x: 0, y: 0)
        deed.size = CGSize(width: 100, height: 100)
        addChild(deed)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            if backButton.contains(location) {
                let transition: SKTransition = SKTransition.fade(withDuration: 1)
                let scene: SKScene = SceneCoordinator.coordinator.gameScene!
                self.view?.presentScene(scene, transition: transition)
            } else if deed.contains(location) {
                print("Shows deed's content.")
            }
        }
    }
}

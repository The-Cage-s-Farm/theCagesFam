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

    private let dialogBox = DialogueBox()
    private let content = "Isso é a escritura do território da fazenda do tio Joe."

    private var deed = SKSpriteNode()

    override func sceneDidLoad() {
        setsComponents()
    }

    private func setsComponents() {
        deed.texture =  SKTexture(imageNamed: "contract")
        deed.position = CGPoint(x: 0, y: 0)
        deed.size = CGSize(width: 300, height: 300)
        addChild(deed)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            if deed.contains(location) {
                dialogBox.zPosition = +1
                dialogBox.position = CGPoint(x: 0, y: -150)
                SceneCoordinator.coordinator.gameScene!.inventory.addItem(itemName: "contract")
                self.addChild(dialogBox)
                self.deed.removeFromParent()
                self.deed.size = CGSize(width: 0, height: 0)
                dialogBox.nextText(answer: content)
            } else if dialogBox.contains(location) {
                let transition: SKTransition = SKTransition.fade(withDuration: 1)
                let scene: SKScene = SceneCoordinator.coordinator.gameScene!
                SceneCoordinator.coordinator.gameScene!.backgroundSound?.play()
                self.view?.presentScene(scene, transition: transition)
            }
        }
    }
}

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
    private let contractContent =   """
                                    ESCRITURA DE COMPRA E VENDA\n
                                    Fazenda Cage\n
                                    TERRENO: num. 6\n
                                    QUADRA: num. 4\n
                                    TAMANHO: 46 hectares\n
                                    DONO: Joe Cage
                                    """
    private lazy var contractTextLabel = SKLabelNode(text: contractContent)
    private var tappedOnce = false

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

    private func showText() {
        deed.alpha = 0.2
        contractTextLabel.position = CGPoint(x: 15, y: 0)
        contractTextLabel.preferredMaxLayoutWidth = 300
        contractTextLabel.fontSize = 16
        contractTextLabel.fontName = "Dogica"
        contractTextLabel.numberOfLines = 9
        contractTextLabel.verticalAlignmentMode = .center
        addChild(contractTextLabel)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            if deed.contains(location) && tappedOnce {
                dialogBox.zPosition = +1
                dialogBox.position = CGPoint(x: 0, y: -150)
<<<<<<< HEAD
                
                guard let contractItem = SceneCoordinator.coordinator.gameScene?.contract else { return }
                SceneCoordinator.coordinator.gameScene!.inventory.addItem(itemName: contractItem)
                
=======
                if SceneCoordinator.coordinator.entryPuzzleScenes["colors"]! {
                    SceneCoordinator.coordinator.gameScene!.inventory.addItem(itemName: "contract")
                }
                SceneCoordinator.coordinator.entryPuzzleScenes["colors"] = false
>>>>>>> dev
                self.addChild(dialogBox)
                self.deed.removeFromParent()
                self.contractTextLabel.removeFromParent()
                self.deed.size = CGSize(width: 0, height: 0)
                dialogBox.nextText(answer: content)
            } else if dialogBox.contains(location) {
                let transition: SKTransition = SKTransition.fade(withDuration: 1)
                let scene: SKScene = SceneCoordinator.coordinator.gameScene!
                SceneCoordinator.coordinator.gameScene!.backgroundSound?.play()
                self.view?.presentScene(scene, transition: transition)
            }
            if deed.contains(location) && !tappedOnce {
                tappedOnce = true
                showText()
            }
        }
    }
}

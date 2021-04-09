//
//  PuzzleScene.swift
//  CagesFarm
//
//  Created by José Mateus Azevedo on 18/03/21.
//

import Foundation
import SpriteKit
import GameplayKit

class PuzzleScene: SKScene {

    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    let colorSequence = [UIColor.red, UIColor.blue, UIColor.red, UIColor.yellow]

    // Puzzle's components
    let checkButton = SKLabelNode()
    let backButton = SKLabelNode()
    let semicircleOne = SemicirclePuzzle()
    let semicircleTwo = SemicirclePuzzle()
    let semicircleThree = SemicirclePuzzle()
    let semicircleFour = SemicirclePuzzle()

    override func sceneDidLoad() {
        initicialDrawing()
        SceneCoordinator.coordinator.puzzleScene = self
    }

    /// Draws Components.
    private func initicialDrawing() {
        semicircleOne.path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 40), radius: 60, startAngle: 0, endAngle: 1.5708, clockwise: true).cgPath
        semicircleOne.strokeColor = UIColor.blue
        semicircleOne.lineWidth = 120
        addChild(semicircleOne)

        semicircleTwo.path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 40), radius: 60, startAngle: 1.5708, endAngle: 3.14159, clockwise: true).cgPath
        semicircleTwo.strokeColor = UIColor.green
        semicircleTwo.lineWidth = 120
        addChild(semicircleTwo)

        semicircleThree.path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 40), radius: 60, startAngle: 3.14159, endAngle: 4.71239, clockwise: true).cgPath
        semicircleThree.strokeColor = UIColor.blue
        semicircleThree.lineWidth = 120
        addChild(semicircleThree)

        semicircleFour.path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 40), radius: 60, startAngle: 4.71239, endAngle: 0, clockwise: true).cgPath
        semicircleFour.strokeColor = UIColor.white
        semicircleFour.lineWidth = 120
        addChild(semicircleFour)

        checkButton.fontName = "Dogica"
        checkButton.text = "Checar"
        checkButton.fontColor = .green
        checkButton.horizontalAlignmentMode = .right
        checkButton.position = CGPoint(x: 75, y: -145)
        addChild(checkButton)

        backButton.fontName = "Dogica"
        backButton.text = "Voltar"
        backButton.horizontalAlignmentMode = .left
        backButton.position = CGPoint(x: -400, y: 130)
        addChild(backButton)
    }

    private func quitScene() {
        SceneCoordinator.coordinator.gameScene!.backgroundSound?.play()
        SceneCoordinator.coordinator.returnToMainScene(view: self.view)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            if checkButton.contains(location) {
                let handledColors = [semicircleTwo.strokeColor, semicircleOne.strokeColor, semicircleFour.strokeColor, semicircleThree.strokeColor]
                if handledColors.elementsEqual(colorSequence) {
                    let transition: SKTransition = SKTransition.fade(withDuration: 1)
                    let scene: SKScene = OpenedTrunkScene(size: UIScreen.main.bounds.size)
                    scene.anchorPoint = .init(x: 0.5, y: 0.5)
                    self.view?.presentScene(scene, transition: transition)
                }
            } else if backButton.contains(location) {
               quitScene()
            }
        }
    }
}

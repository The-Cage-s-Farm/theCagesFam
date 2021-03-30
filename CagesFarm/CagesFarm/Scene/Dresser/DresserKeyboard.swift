//
//  DresserKeyboard.swift
//  CagesFarm
//
//  Created by Tales Conrado on 26/03/21.
//

import Foundation
import SpriteKit
import GameplayKit
import UIKit

class DresserKeyboard: SKScene {
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    let numberSequence = [6,5,4,6]
    let keysXPosition: [Double] = [-82.0, -6.0, 74]
    let keysYIncrement: Double = 60

    // Puzzle's components
    let backButton = SKLabelNode()
    let keyboardTexture = SKTexture(imageNamed: "teclado-matricial")
    lazy var keyboard = SKSpriteNode(texture: keyboardTexture)

    override func sceneDidLoad() {
        initialDrawing()
    }

    private func setupKeyboard() {
        var currentY = 117.0
        for digit in 1...9 {
            let keyNumber = KeyboardNumber(digit: digit)
            var xPosition = (digit % 3) - 1
            if xPosition == -1 { xPosition = 2 }

            if (digit % 3 == 1) { currentY -= keysYIncrement }

            keyNumber.position = CGPoint(x: keysXPosition[xPosition], y: currentY)
            keyNumber.zPosition = +2
            keyboard.addChild(keyNumber)
        }
    }

    private func setupPasswordViewer() {
        let viewer = KeyboardNumber(digit: 0)
        viewer.digit.fontColor = .black
        viewer.digit.text = ""
        viewer.digit.horizontalAlignmentMode = .center
        viewer.position = CGPoint(x: keysXPosition[1], y: 110)
        keyboard.addChild(viewer)
    }

    // Draws Components.
    private func initialDrawing() {

        backButton.fontName = "Dogica"
        backButton.text = "Voltar"
        backButton.fontSize = 22
        backButton.horizontalAlignmentMode = .left
        backButton.position = CGPoint(x: -400, y: 130)
        let xPositionOfBack = UIScreen.main.bounds.width * 0.45
        backButton.constraints = [SKConstraint.positionX(SKRange(lowerLimit: -xPositionOfBack)),
                                  SKConstraint.positionY(SKRange(lowerLimit: 130))]
        addChild(backButton)

        keyboard.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        keyboard.setScale(0.8)
        addChild(keyboard)

        setupKeyboard()
        setupPasswordViewer()
    }

    func touchDown(atPoint position: CGPoint) {

    }

    func touchMoved(toPoint position: CGPoint) {

    }

    func touchUp(atPoint position: CGPoint) {
        // guard let keyPressed = atPoint(position) as? KeyboardNumber else { return }
    }
}

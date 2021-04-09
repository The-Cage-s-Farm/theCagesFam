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
    let numberSequence = "6546"
    let keysXPosition: [Double] = [-82.0, -6.0, 74]
    let keysYIncrement: Double = 60

    // Puzzle's components
    let backButton = SKLabelNode()
    let viewer = KeyboardNumber(digit: 0)
    let keyboardTexture = SKTexture(imageNamed: "teclado-matricial")
    lazy var keyboard = SKSpriteNode(texture: keyboardTexture)

    override func sceneDidLoad() {
        initialDrawing()
    }

    private func setupKeyboard() {
        var currentY = 117.0
        for digit in 1...12 {
            let keyNumber = KeyboardNumber(digit: digit)
            var xPosition = (digit % 3) - 1
            if xPosition == -1 { xPosition = 2 }

            if (digit % 3 == 1) { currentY -= keysYIncrement }

            keyNumber.position = CGPoint(x: keysXPosition[xPosition], y: currentY)
            keyNumber.zPosition = +2

            if digit < 10 || digit == 11 {
                if digit == 11 {
                    keyNumber.digit.text = "0"
                    keyNumber.numberValue = 0
                }

                keyNumber.didTouchNumberKey = didTouchNumberKey(of:)
            } else {
                keyNumber.digit.text = ""
                keyNumber.checkConfirmCancelAction = checkConfirmCancelAction(isClearButton:)
            }

            keyboard.addChild(keyNumber)
        }
    }

    private func checkConfirmCancelAction(isClearButton: Bool) {
        if isClearButton {
            clearViewer()
        } else {
            checkValidCode()
        }
    }

    private func checkValidCode() {
        let isValid = viewer.digit.text ?? "" == numberSequence ? true : false
        if isValid {
            addKeyToInventory()
            SceneCoordinator.coordinator.entryPuzzleScenes["keyboard"] = false
            SceneCoordinator.coordinator.gameScene!.backgroundSound?.play()
            SceneCoordinator.coordinator.returnToMainScene(view: self.view)
        }
    }

    private func addKeyToInventory() {
        guard let keysItem = SceneCoordinator.coordinator.gameScene?.keys else { return }
        SceneCoordinator.coordinator.addItemToInventory(item: keysItem)
    }

    private func clearViewer() {
        let currentText = viewer.digit.text ?? ""
        if !currentText.isEmpty {
            viewer.digit.text?.removeLast()
        }
    }

    private func setupPasswordViewer() {
        viewer.shouldHighlight = false
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

    private func vibrateValidCode() {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }

    private func didExceedNumberCount() {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }

    private func didTouchNumberKey(of number: Int) {
        let textSize = viewer.digit.text?.count ?? 0
        if !(textSize >= 4) {
            viewer.digit.text?.append("\(number)")
        } else {
            didExceedNumberCount()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if backButton.contains(location) {
                SceneCoordinator.coordinator.gameScene!.backgroundSound?.play()
                SceneCoordinator.coordinator.returnToMainScene(view: self.view)
            }
        }
    }
}

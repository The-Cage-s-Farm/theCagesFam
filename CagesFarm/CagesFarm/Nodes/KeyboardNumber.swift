//
//  KeyboardNumber.swift
//  CagesFarm
//
//  Created by Tales Conrado on 26/03/21.
//

import SpriteKit

class KeyboardNumber: SKSpriteNode {

    var digit: SKLabelNode!
    var numberValue: Int?
    var backgroundOverlay: SKSpriteNode!
    var shouldHighlight = true
    var didTouchNumberKey: ((Int) -> Void)?
    var checkConfirmCancelAction: ((Bool) -> Void)?

    convenience init(digit: Int) {
        self.init()
        self.size = CGSize(width: 43, height: 45)
        self.numberValue = digit
        self.digit = SKLabelNode(text: "\(digit)")
        setupNodes()
    }

    private func setupNodes() {
        setupDigit()
        setupOverlay()
    }

    private func setupOverlay() {
        backgroundOverlay = SKSpriteNode(color: .gray, size: CGSize(width: 43, height: 45))
        backgroundOverlay.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundOverlay.alpha = 0.0
        backgroundOverlay.position = CGPoint(x: 1, y: 10)
        backgroundOverlay.isUserInteractionEnabled = true
        isUserInteractionEnabled = true
        self.addChild(backgroundOverlay)
    }

    private func setupDigit() {
        digit.position = CGPoint(x: 0.5, y: 0.5)
        digit.fontColor = .white
        digit.fontSize = 17
        digit.fontName = "Dogica"
        digit.zPosition = +10
        self.addChild(digit)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if shouldHighlight {
            let alphaAction1 = SKAction.fadeAlpha(to: 1, duration: 0.05)
            backgroundOverlay.run(alphaAction1)
            didTouchNumberKey?(numberValue ?? 0)
            let isCancel = numberValue == 10 ? true : false

            checkConfirmCancelAction?(isCancel)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if shouldHighlight {
            let alphaAction2 = SKAction.fadeAlpha(to: 0, duration: 0.2)
            let actions = SKAction.sequence([alphaAction2])
            backgroundOverlay.run(actions)
        }
    }
}

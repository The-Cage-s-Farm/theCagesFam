//
//  KeyboardNumber.swift
//  CagesFarm
//
//  Created by Tales Conrado on 26/03/21.
//

import SpriteKit

class KeyboardNumber: SKSpriteNode {

    var digit: SKLabelNode!
    var backgroundOverlay: SKSpriteNode!

    convenience init(digit: Int) {
        self.init()
        self.size = CGSize(width: 43, height: 45)
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
        backgroundOverlay.zPosition = +20
        backgroundOverlay.isUserInteractionEnabled = true
        isUserInteractionEnabled = true
        self.addChild(backgroundOverlay)
    }

    private func setupDigit() {
        digit.position = CGPoint(x: 0.5, y: 0.5)
        digit.fontColor = .white
        digit.fontSize = 17
        digit.fontName = "Dogica"
        self.addChild(digit)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let alphaAction1 = SKAction.fadeAlpha(to: 1, duration: 0.2)
        let alphaAction2 = SKAction.fadeAlpha(to: 0, duration: 0.2)
        let actions = SKAction.sequence([alphaAction1, alphaAction2])
        backgroundOverlay.run(actions)
    }
}

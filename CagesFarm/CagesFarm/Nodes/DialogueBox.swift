//
//  DialogueBox.swift
//  CagesFarm
//
//  Created by Gilberto Magno on 3/12/21.
//

import Foundation

import SpriteKit

class DialogueBox: SKSpriteNode {
    
    var dialogTexture: SKTexture?
    var dialog: SKLabelNode?
    var nextOption =  SKSpriteNode(texture: SKTexture(imageNamed: "Seta"), color: .clear, size: SKTexture(imageNamed: "Seta").size())
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init() {
        dialogTexture = SKTexture(imageNamed: "DialogBox")
        let attributedText = NSAttributedString(string: "a", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 28)])
        dialog = SKLabelNode(attributedText: attributedText)
        super.init(texture: dialogTexture, color: .clear, size: (dialogTexture?.size())!)
        organizeDialog()

    }
    
    func organizeDialog() {
        
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        let fade = SKAction.fadeOut(withDuration: 0)
        self.position = CGPoint(x: 0, y: -100)
        self.setScale(1)
        self.run(fade)
        self.run(fadeIn)
        self.addChild(dialog!)
        dialog?.constraints = [SKConstraint.positionX(SKRange(lowerLimit: 30, upperLimit: 300)),SKConstraint.positionY(SKRange(lowerLimit: 0, upperLimit: 200))]
       // dialog?.position = CGPoint(x: 50, y: 0)
        self.addChild(nextOption)
        nextOption.size = CGSize(width: self.size.width/16, height: self.size.height/3)
        print(15*self.size.width/16)
        nextOption.constraints = [  SKConstraint.positionX(
                                    SKRange(lowerLimit: 15*self.size.width/32)),
                                    SKConstraint.positionY(SKRange(upperLimit: -self.size.height/3))]
        dialog?.zPosition = +1
        nextOption.zPosition = +1

    }

    func nextText(answer: String) {
        var runCount = 0
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            runCount += 1
            self.dialog?.attributedText = NSAttributedString(string: answer.substring(with: 0..<runCount),
                                                             attributes: [NSAttributedString.Key.font: UIFont.pixelPlay(17)])
            if runCount == answer.count {
                timer.invalidate()
            }

        }
        
    }
}

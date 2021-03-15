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
    var nextOption: SKSpriteNode?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
     init() {
        dialogTexture = SKTexture(imageNamed: "DialogBox")
        let attributedText = NSAttributedString(string: "a", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 28)])
        dialog = SKLabelNode(attributedText: attributedText)

        let fadeIn = SKAction.fadeIn(withDuration: 1)
        let fade = SKAction.fadeOut(withDuration: 0)
        super.init(texture: dialogTexture, color: .clear, size: (dialogTexture?.size())!)
        self.position = CGPoint(x: 0, y: -220)
        self.size = CGSize(width: 700, height: 300)
        self.run(fade)
        self.run(fadeIn)
        self.addChild(dialog!)
        dialog?.zPosition = +1
        
    }
    
    func organizeDialog() {
        
     
        
    }
    
    func nextText(answer: String){
        var runCount = 0
        Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { timer in
            runCount += 1
            self.dialog?.attributedText = NSAttributedString(string: answer.substring(with: 0..<runCount), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])
            if runCount == answer.count {
                timer.invalidate()
            }
            
            
        }
        
    }
    
    
    
    
    
}

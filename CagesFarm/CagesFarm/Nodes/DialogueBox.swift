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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
     init() {
        dialogTexture = SKTexture(imageNamed: "DialogBox")
        let attributedText = NSAttributedString(string: "a", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        dialog = SKLabelNode(attributedText: <#T##NSAttributedString?#>)
        
        super.init(texture: dialogTexture, color: .clear, size: (dialogTexture?.size())!)
  
    }
    
    func organizeDialog() {
        
        
        
    }
    
    
    
}

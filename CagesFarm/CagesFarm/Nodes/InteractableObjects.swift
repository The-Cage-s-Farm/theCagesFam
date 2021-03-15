//
//  InteractableObjects.swift
//  CagesFarm
//
//  Created by Gilberto Magno on 3/11/21.
//


import Foundation

import SpriteKit

extension SKSpriteNode {
    func drawBorder(color: UIColor, width: CGFloat) {
        let shapeNode = SKShapeNode(rect: frame)
        shapeNode.fillColor = .clear
        shapeNode.strokeColor = color
        shapeNode.lineWidth = width
        addChild(shapeNode)
    }
}

public enum ObjectType :Int {
    case quadro,
    enemy1,
    enemy2
}


public class InteractableObjects: SKSpriteNode {
    let objectType :ObjectType
    let frontTexture :SKTexture
    let objectName: String?
    var isCloseInteract = false
    var answers: [String]
    var actualAnswer = 0
    var isIteracting = false
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func microInteraction(player: Characters){
        if player.frame.minX <= self.frame.maxX && player.frame.maxX >= self.frame.minX {
            self.isCloseInteract = true
//            self.removeAllChildren()
//            drawBorder(color: .black, width: 30)
            
        }else {
            self.isCloseInteract = false
//            self.removeAllChildren()
//            drawBorder(color: .clear, width: 0)
        }
    }
    
    func nextDialogue() {
        if !(actualAnswer == answers.count - 1){
            
            actualAnswer += 1
        
        }
    }
    
    init(objectType: ObjectType) {
        self.objectType = objectType
    
        switch objectType {
        case .quadro:
            frontTexture = SKTexture(imageNamed: "Quadro")
            answers = ["Baú de travesseiro... que estranho","Será que a pintura é sobre este quarto... e o travesseiro esteja escondendo algo?..."]
            self.objectName = "Tony"
        case .enemy1:
            frontTexture = SKTexture(image: #imageLiteral(resourceName: "TemplateCard1.png"))
            self.objectName = "Tony"
            answers = []
        case .enemy2:
            frontTexture = SKTexture(image: #imageLiteral(resourceName: "TemplateCard1.png"))
            self.objectName = "Tony"
            answers = []
        }
        
        super.init(texture: frontTexture, color: .clear, size: frontTexture.size())
        
        
        
        
    }
    
}

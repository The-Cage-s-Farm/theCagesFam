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
    interruptor,
    cama,
    comoda,
    tapete,
    bau

}


public class InteractableObjects: SKSpriteNode {
    let objectType :ObjectType
    let frontTexture :SKTexture
    let objectName: String?
    var isCloseInteract = false
    var answers: [String]
  //  var options: [String]
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
            self.objectName = "Quadro"
        case .interruptor:
            self.objectName = "Interruptor"
            frontTexture = SKTexture(imageNamed: "InterruptorOff")
            answers = ["Hmm, pergunto-me se este interruptor ligará a luz"]
            func lightOn(){
                
            }
        case .comoda:
            self.objectName = "Comoda"
            frontTexture = SKTexture(imageNamed: self.objectName!)
            answers = []
        case .tapete:
            self.objectName = "Tapete"
            frontTexture = SKTexture(imageNamed: self.objectName!)
            answers = ["Interessante, esta é a mesma imagem do Baú"]
        case .cama:
            self.objectName = "Cama"
            frontTexture = SKTexture(imageNamed: self.objectName!)
            answers = []
        case .bau:
            self.objectName = "Baú"
            frontTexture = SKTexture(imageNamed: self.objectName!)
            answers = []
        }
        
        super.init(texture: frontTexture, color: .clear, size: frontTexture.size())
        
        
        
        
    }
    
}

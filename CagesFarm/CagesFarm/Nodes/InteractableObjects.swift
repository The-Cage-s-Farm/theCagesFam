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

        for layer in self.children {

            if layer.name == "border" {

                layer.removeFromParent()

            }

        }

        let imageSize = self.texture?.size()

        let lineWidth = (imageSize!.width / self.size.width) * width

        let shapeNode = SKShapeNode(rect: CGRect(x: -imageSize!.width/2, y: -imageSize!.height/2, width: imageSize!.width, height: imageSize!.height))
        shapeNode.fillColor = .clear
        shapeNode.strokeColor = color
        shapeNode.lineWidth = lineWidth
        shapeNode.name = "border"
        shapeNode.zPosition = 999
        self.addChild(shapeNode)

        self.zPosition = 1000

    }

}

public enum ObjectType :Int {
    case quadro,
    interruptor,
    cama,
    comoda,
    tapete,
    bau,
    quadroPerspectiva

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
    var isMicroInteractionON = false
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func microInteraction(player: Characters){
        if player.frame.minX <= self.frame.maxX && player.frame.maxX >= self.frame.minX {
            self.isCloseInteract = true
            if !isMicroInteractionON {
                isMicroInteractionON = !isMicroInteractionON
                let shapeNode = SKShapeNode(circleOfRadius: 6)
                shapeNode.fillColor = .green
                self.addChild(shapeNode)
                shapeNode.zPosition = +1
                shapeNode.position = CGPoint(x: 0, y: 40)
            }
        }else {
            self.isCloseInteract = false
            self.removeAllChildren()
            isMicroInteractionON = false
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
            answers = ["-- Baú de travesseiro... que estranho","-- Será que a pintura é sobre este quarto... e o travesseiro esteja escondendo algo?..."]
            self.objectName = "Quadro"
        case .interruptor:
            self.objectName = "Interruptor"
            frontTexture = SKTexture(imageNamed: "InterruptorOff")
            answers = ["-- Hmm, pergunto-me se este interruptor ligará a luz"]
            func lightOn(){


            }
        case .comoda:
            self.objectName = "Comoda"
            frontTexture = SKTexture(imageNamed: self.objectName!)
            answers = []
        case .tapete:
            self.objectName = "TapeteQuadrado"
            frontTexture = SKTexture(imageNamed: self.objectName!)
            answers = ["-- Interessante, esta é a mesma imagem do Baú"]
        case .cama:
            self.objectName = "Cama"
            frontTexture = SKTexture(imageNamed: self.objectName!)
            answers = []
        case .bau:
            self.objectName = "Baú"
            frontTexture = SKTexture(imageNamed: self.objectName!)
            answers = []
        case .quadroPerspectiva:
            self.objectName = "QuadroPerspectiva"
            frontTexture = SKTexture(imageNamed: self.objectName!)
            answers = []

        }
        
        super.init(texture: frontTexture, color: .clear, size: frontTexture.size())
        
        
        
        
    }
    
}

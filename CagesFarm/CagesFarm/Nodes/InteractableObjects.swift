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
        
        for layer in self.children where layer.name == "border" {
            layer.removeFromParent()
            
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
         quadroPerspectiva,
         door
}

public class InteractableObjects: SKSpriteNode,ImageRetriever {
    let objectType :ObjectType
    var frontTexture :SKTexture = SKTexture()
    var objectName: String?
    var isCloseInteract = false
    var answers: [String]?
    var options: [String]?
    var itemToGive: ItemType?
    var actualAnswer = 0
    var isIteracting = false
    var isMicroInteractionON = false
    var canProceedInteraction = true
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func microInteraction(player: Characters) {
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
        } else {
            self.isCloseInteract = false
            self.removeAllChildren()
            isMicroInteractionON = false
        }
    }
    
    func nextDialogue() {

        guard let answers = answers else {return}

        updateAnswersArray()

        if !(actualAnswer == answers.count - 1) {
            actualAnswer += 1
        }
    }

    private func updateAnswersArray() {
        switch objectType {
        case .interruptor:
            if SceneCoordinator.coordinator.shouldShowInterrupterScene {
                answers = ["-- Bem melhor de enxergar assim."]
            }
        default:
            print("")
        }
    }

    func makeRatio(x:CGFloat, y: CGFloat) {
        self.xScale = x
        self.yScale = y
    }
    
    func giveItem() {
        
    }
    
    init(objectType: ObjectType) {
        self.objectType = objectType
        
        switch objectType {
        case .quadro:
            self.objectName = "Quadro"
        case .interruptor:
            self.objectName = "Interruptor"
        case .comoda:
            self.objectName = "comoda_fechada"
        case .tapete:
            self.objectName = "TapeteQuadrado"
        case .cama:
            self.objectName = "cama"
        case .bau:
            self.objectName = "Bau"
        case .quadroPerspectiva:
            self.objectName = "QuadroPerspectiva"
        case .door:
            self.objectName = "door"
        }
            super.init(texture: frontTexture, color: .clear, size: frontTexture.size())

        switch objectType {
        case .quadro:
            answers = ["-- Baú de travesseiro... que estranho","-- Será que a pintura é sobre este quarto... e o travesseiro esteja escondendo algo?..."]
            self.texture = SKTexture(image: image(.quadro))
            self.size = (self.texture?.size())!
        case .interruptor:
            answers = ["-- Hmm, pergunto-me se este interruptor ligará a luz"]
            self.texture = SKTexture(image: image(.lightSwitchOn))
            self.size = (self.texture?.size())!
        case .comoda:
            answers = [  "Hmm, consigo abrir a primeira gaveta sem problemas..."
                            + " Porem não tem nada.","Consigo abrir a segunda gaveta, há um canivete",
                         "A Terceira gaveta possui um senha para abrir, qual será?",
                         "Outra gaveta sem nada"]
            self.texture = SKTexture(image: image(.comodaFechada))
            self.size = (self.texture?.size())!
        case .tapete:
            answers = ["-- Interessante, esta é a mesma imagem do Baú"]
            self.texture = SKTexture(image: image(.tapeteQuadrado))
            self.size = (self.texture?.size())!
        case .cama:
            self.objectName = "cama"
            self.texture = SKTexture(image: image(.cama))
            self.size = (self.texture?.size())!
            answers = ["Parecia que havia algo escondido no travesseiro... Era só minha imaginação."]
        case .bau:
            answers = ["Um Pequeno puzzle? O que faço?"]
            self.texture = SKTexture(image: image(.bau))
            self.size = (self.texture?.size())!
        case .quadroPerspectiva:
            answers = ["Bonito"]
            self.texture = SKTexture(image: image(.quadroPerspectiva))
            self.size = (self.texture?.size())!
        case .door:
            self.objectName = "door"
            frontTexture = SKTexture(imageNamed: self.objectName!)
            answers = ["Preciso sair desse lugar... Mas está trancada. Tenho que encontrar a chave."]
        }

    }
}

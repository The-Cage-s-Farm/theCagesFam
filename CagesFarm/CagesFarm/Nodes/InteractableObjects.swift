//
//  InteractableObjects.swift
//  CagesFarm
//
//  Created by Gilberto Magno on 3/11/21.
//

import Foundation
import SpriteKit

//swiftlint:disable function_body_length cyclomatic_complexity
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
         door,
         doorOne,
         doorTwo,
         doorThree
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

    func updateAnswersArray() {
        switch objectType {
        case .interruptor:
            if SceneCoordinator.coordinator.shouldShowInterrupterScene {
                answers = ["- Bem melhor de enxergar assim. (Clique na seta para fechar a caixa de dialogo.)"]
            }
        case .bau:
            if !SceneCoordinator.coordinator.entryPuzzleScenes["colors"]! {
                answers = ["- Já consegui a escritura da fazenda! Mas vou dar uma olhada novamente."]
            }
        case .door:
            if SceneCoordinator.coordinator.canLeaveBedroom {
                answers = ["A chave funcionou! Vou dar o fora daqui."]
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
        case .doorOne:
            self.objectName = "doorOne"
        case .doorTwo:
            self.objectName = "doorTwo"
        case .doorThree:
            self.objectName = "doorThree"
        }
        
        super.init(texture: frontTexture, color: .clear, size: frontTexture.size())
        
        switch objectType {
        case .quadro:
            answers = ["- Que quadro estranho! Chegar dar arrepios..."]
            self.texture = SKTexture(image: image(.quadro))
            self.size = (self.texture?.size())!
        case .interruptor:
            answers = ["- Hmm, pergunto-me se este interruptor ligará a luz. (Toque no interruptor novamente)"]
            self.texture = SKTexture(image: image(.lightSwitchOn))
            self.size = (self.texture?.size())!
        case .comoda:
            answers = [  "Hmm, consigo abrir a primeira gaveta sem problemas..."
                            + " Mas não tem nada.","Consigo abrir a segunda gaveta, há um canivete.",
                         "A terceira gaveta possui um senha para abrir, qual será?",
                         "Só perda de tempo outra gaveta sem nada."]
            self.texture = SKTexture(image: image(.comodaFechada))
            self.size = (self.texture?.size())!
        case .tapete:
            answers = ["- Interessante, esta é a mesma imagem do baú."]
            self.texture = SKTexture(image: image(.tapeteQuadrado))
            self.size = (self.texture?.size())!
        case .cama:
            self.objectName = "cama"
            self.texture = SKTexture(image: image(.cama))
            self.size = (self.texture?.size())!
            answers = ["Parecia que havia algo escondido no travesseiro... Ah, era só minha imaginação."]
        case .bau:
            answers = ["Um pequeno puzzle? O que faço?"]
            self.texture = SKTexture(image: image(.bau))
            self.size = (self.texture?.size())!
        case .quadroPerspectiva:
            answers = ["Esse quadro é bonito!"]
            self.texture = SKTexture(image: image(.quadroPerspectiva))
            self.size = (self.texture?.size())!
        case .door:
            self.objectName = "door"
            self.texture = SKTexture(imageNamed: self.objectName!)
            self.size = (self.texture?.size())!
            answers = ["Preciso sair desse lugar... Mas está trancada. Tenho que encontrar a chave."]
        case .doorOne:
            self.objectName = "doorOne"
            self.texture = SKTexture(image: image(.door))
            self.size = (self.texture?.size())!
            answers = ["A porta está fechada! Preciso sair desse lugar. Vou tentar a próxima"]
        case .doorTwo:
            self.objectName = "doorTwo"
            self.texture = SKTexture(image: image(.door))
            self.size = (self.texture?.size())!
            answers = ["A porta está fechada! Preciso sair desse lugar. Vou tentar a próxima"]
        case .doorThree:
            self.objectName = "doorThree"
            self.texture = SKTexture(image: image(.door))
            self.size = (self.texture?.size())!
            answers = ["Oh a porta está aberta, vou sair desse lugar."]
        }
    }
}

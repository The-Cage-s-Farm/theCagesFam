//
//  changeTheName.swift
//  CagesFarm
//
//  Created by Gilberto Magno on 3/9/21.
//

import Foundation

import SpriteKit


public enum CharacterType :Int {
    case tony,
    MrCage,
    MrsCage
}


public class Characters: SKSpriteNode {
    let characterType :CharacterType
    let frontTexture :SKTexture
    let Charactername: String?
    var isWalking = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    
    func walk(posx: CGFloat){
        let beginWalk = SKAction.run {
            self.isWalking = true
        }
        let andar = SKAction.move(by: CGVector(dx: posx - self.position.x, dy: self.position.y), duration: 1)
        let endWalk = SKAction.run {
            self.isWalking = false
        }
        let sequence = SKAction.sequence([beginWalk,andar,endWalk])
        self.run(sequence)
        
    }
    
    
    init(characterType: CharacterType) {
        self.characterType = characterType
        
        switch characterType {
        case .tony:
            frontTexture = SKTexture(imageNamed: "Image")
            self.Charactername = "Tony"
        case .MrCage:
            frontTexture = SKTexture(image: #imageLiteral(resourceName: "TemplateCard1.png"))
            self.Charactername = "Tony"
        case .MrsCage:
            frontTexture = SKTexture(image: #imageLiteral(resourceName: "TemplateCard1.png"))
            self.Charactername = "Tony"
        }
        
        super.init(texture: frontTexture, color: .clear, size: frontTexture.size())
        
        
        
        
    }
    
}

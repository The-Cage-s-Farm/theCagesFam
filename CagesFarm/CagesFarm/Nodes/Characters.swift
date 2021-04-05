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
         mrCage,
         mrsCage
}



public class Characters: SKSpriteNode {
    let characterType :CharacterType
    var textures :[SKTexture] = []
    let characterName: String?
    var isWalking = false
    var actualImageID = 0
    var feeling: String = "Sorriso"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func walk(posx: CGFloat) {

        let beginWalk = SKAction.run {
            self.isWalking = true
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                self.actualImageID += 1
                self.actualImageID = self.actualImageID%6
                self.texture = self.textures[self.actualImageID]
                if !self.isWalking {
                    timer.invalidate()
                }
            }
        }
        let distance = abs(posx - self.position.x)
        let andar = SKAction.move(by: CGVector(dx: posx - self.position.x, dy: 0), duration: TimeInterval(distance/120))
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
            for number in Range(0...5) {
                self.textures.append(SKTexture(imageNamed: "sprite_\(number)"))
            }
            self.characterName = "Tony"
        case .mrCage:
            for number in Range(0...5) {
                self.textures.append(SKTexture(imageNamed: "sprite_\(number)"))
            }
            self.characterName = "Tony"
        case .mrsCage:
            for number in Range(0...5) {
                self.textures.append(SKTexture(imageNamed: "sprite_\(number)"))
            }
            
            self.characterName = "Tony"
        }
        
        super.init(texture: textures[0], color: .clear, size: textures[0].size())
    }
}

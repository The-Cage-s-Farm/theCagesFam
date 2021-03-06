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
    var isReallyWalking = true
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func walk(posx: CGFloat,gameScene: SKScene) {
        let offset = 100
        let beginWalk = SKAction.run {
            
            self.isWalking = true
            self.isReallyWalking = true
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                self.actualImageID += 1
                self.actualImageID = self.actualImageID%6
                self.texture = self.textures[self.actualImageID]
                if !self.isWalking || !self.isReallyWalking {

                    timer.invalidate()
                }
            }
        }
        let distance = abs(posx - self.position.x)
        print(gameScene.size.width)
        var andar = SKAction()
        if posx > gameScene.size.width/2-CGFloat(offset) {
            andar = SKAction.move(by: CGVector(dx: gameScene.size.width/2-CGFloat(offset) - self.position.x, dy: 0), duration: TimeInterval(distance/120))
        }else if posx < -gameScene.size.width/2 + CGFloat(offset) {
             andar = SKAction.move(by: CGVector(dx: -gameScene.size.width/2 + CGFloat(offset) - self.position.x, dy: 0), duration: TimeInterval(distance/120))

        }else {
             andar = SKAction.move(by: CGVector(dx: posx - self.position.x, dy: 0), duration: TimeInterval(distance/120))
        }
        let endWalk = SKAction.run {
            self.isReallyWalking = false
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
            self.characterName = "tony"
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

//
//  changeTheEntity.swift
//  CagesFarm
//
//  Created by Gilberto Magno on 3/9/21.
//

import Foundation
import SpriteKit
import GameplayKit

class SpriteComponent: GKComponent {
  let node: SKSpriteNode

  init(texture: SKTexture) {
    node = SKSpriteNode(texture: texture, color: .white, size: texture.size())
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

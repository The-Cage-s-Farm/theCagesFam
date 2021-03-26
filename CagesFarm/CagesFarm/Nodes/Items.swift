//
//  Items.swift
//  CagesFarm
//
//  Created by Gilberto Magno on 3/24/21.
//

import Foundation
import SpriteKit

enum ItemType: String {
    case knife,
         keys,
         contract

}

class Items: SKSpriteNode {

    let itemName: String?
    let image: SKTexture?
    var itemType: ItemType
    var actualPosition: Int = 0

    init(itemType: ItemType) {
//        self.texture = image
//        self.color = .clear
//        self.size = self.texture!.size()
        self.itemType = itemType

        switch itemType {
        case .contract:
            itemName = "contract"
            image = SKTexture(imageNamed: itemName!)
        case .keys:
            itemName = "keys"
            image = SKTexture(imageNamed: itemName!)
        case .knife:
            itemName = "knife"
            image = SKTexture(imageNamed: itemName!)

        }
        
        super.init(texture: image, color: .clear, size: image!.size())

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

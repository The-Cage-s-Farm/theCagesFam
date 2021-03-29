//
//  Inventory.swift
//  CagesFarm
//
//  Created by Gilberto Magno on 3/22/21.
//

import Foundation
import SpriteKit

class Inventory: SKSpriteNode {
    var items: [Items]
    var textureBackground: SKSpriteNode = SKSpriteNode(imageNamed: "Inventario")
    var squares: [SKShapeNode] = []
    var auxPositionItem = 0
    func organizeInventory() {
        for increment in 0...4 {
            squares.append(SKShapeNode(rect: CGRect(x: -30, y: 128 - increment*65, width: 40, height: 40), cornerRadius: 5))
            self.addChild(squares[increment])
            squares[increment].fillColor = .gray
            squares[increment].zPosition = +1
        }

        organizeItems()

        self.size = CGSize(width: 70, height: UIScreen.main.bounds.height)
        //self.addChild(textureBackground)
        self.position = CGPoint(x: 339, y: 0)
    }

    func organizeItems() {

        for item in items {
            if item.parent == nil {
                addChild(item)
                item.size = squares[auxPositionItem].frame.size
                item.setScale(0.95)
                item.position.x = squares[auxPositionItem].frame.origin.x + item.size.width/2 + 1
                item.position.y = squares[auxPositionItem].frame.origin.y + item.size.height/2 + 1
                auxPositionItem += 1
                item.zPosition = +1
            }

        }

    }

    func addItem(itemName: String) {
        guard let unwrappedItemType = ItemType(rawValue: itemName) else { return }
        items.append(Items(itemType: unwrappedItemType))
        organizeItems()
    }
    func removeItem() {}

    func touchItem() {}

    init(items: [Items]) {
        self.items = items
        super.init(texture: self.textureBackground.texture, color: .clear, size: (self.textureBackground.texture?.size())!)
        organizeInventory()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

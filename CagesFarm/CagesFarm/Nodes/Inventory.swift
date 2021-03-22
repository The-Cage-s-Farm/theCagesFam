//
//  Inventory.swift
//  CagesFarm
//
//  Created by Gilberto Magno on 3/22/21.
//

//import Foundation
//import SpriteKit
//
//
//class Inventory: SKSpriteNode {
//    var items: [String]
//    var textureBackground: SKSpriteNode = SKSpriteNode(imageNamed: "Inventario")
//    var squares: [SKShapeNode] = []
//    func organizeInventory() {
//        for i in 0...4 {
//            squares.append(SKShapeNode(rect: CGRect(x: .zero, y: .zero + i*45, width: 40, height: 40), cornerRadius: 5))
//            self.addChild(squares[i])
//        }
//        self.size = CGSize(width: 70, height: UIScreen.main.bounds.height)
//        self.addChild(textureBackground)
//
//
//    }
//
//    init(items: [String]) {
//        self.items = items
//        super.init(texture: textureBackground, color: .clear, size: textureBackground.size())
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//
//
//}

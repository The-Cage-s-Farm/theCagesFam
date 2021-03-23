//
//  SemicirclePuzzle.swift
//  CagesFarm
//
//  Created by José Mateus Azevedo on 20/03/21.
//

import SpriteKit

class SemicirclePuzzle: SKShapeNode {

    let colors = [UIColor.red, UIColor.blue, UIColor.yellow, UIColor.black, UIColor.green, UIColor.white]
    var colorIndex = 0

    override init() {
        super.init()
        self.isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.strokeColor = self.colors[self.colorIndex]
        colorIndex += 1
        if colorIndex >= colors.count {
            colorIndex = 0
        }
    }
}

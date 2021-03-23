//
//  PuzzleScene.swift
//  CagesFarm
//
//  Created by José Mateus Azevedo on 18/03/21.
//

import Foundation
import SpriteKit
import GameplayKit
import UIKit

class PuzzleScene: SKScene {

    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    let colorSequence = [UIColor.red, UIColor.blue, UIColor.red, UIColor.yellow]

    let button = SKLabelNode()
    let semicircleOne = SemicirclePuzzle()
    let semicircleTwo = SemicirclePuzzle()
    let semicircleThree = SemicirclePuzzle()
    let semicircleFour = SemicirclePuzzle()

    override func sceneDidLoad() {
        initicialDrawing()
    }

    func initicialDrawing() {

        semicircleOne.path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 40), radius: 60, startAngle: 0, endAngle: 1.5708, clockwise: true).cgPath

        semicircleOne.strokeColor = UIColor.blue
        semicircleOne.lineWidth = 120
        addChild(semicircleOne)

        semicircleTwo.path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 40), radius: 60, startAngle: 1.5708, endAngle: 3.14159, clockwise: true).cgPath

        semicircleTwo.strokeColor = UIColor.green
        semicircleTwo.lineWidth = 120
        addChild(semicircleTwo)

        semicircleThree.path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 40), radius: 60, startAngle: 3.14159, endAngle: 4.71239, clockwise: true).cgPath

        semicircleThree.strokeColor = UIColor.blue
        semicircleThree.lineWidth = 120
        addChild(semicircleThree)


        semicircleFour.path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 40), radius: 60, startAngle: 4.71239, endAngle: 0, clockwise: true).cgPath
        
        semicircleFour.strokeColor = UIColor.white
        semicircleFour.lineWidth = 120
        addChild(semicircleFour)

        button.fontName = "Chalkduster"
        button.text = "Checar"
        button.horizontalAlignmentMode = .right
        button.position = CGPoint(x: 65, y: -145)
        addChild(button)

    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            if button.contains(location) {
                let handledColors = [semicircleOne.strokeColor, semicircleTwo.strokeColor, semicircleThree.strokeColor, semicircleFour.strokeColor]
                if handledColors.elementsEqual(colorSequence) {
                    print("Correct Sequence.")
                } else {
                    print("Wrong Sequence.")
                }
            }
        }
    }

}

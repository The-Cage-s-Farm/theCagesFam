//
//  FaceCharacters.swift
//  CagesFarm
//
//  Created by Gilberto Magno on 4/6/21.
//
//

import  Foundation
import SpriteKit
import UIKit

public class FaceCharacters: SKSpriteNode, ImageRetriever {
    var textures :[SKTexture] = []
    let characterName: String? = "tony"
    var isTalking = false
    var actualImageID = 0
    var feeling: String = "Smiling"

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(texture: textures[0], color: .clear, size: textures[0].size())
    }
}

//
//  InterrupterScene.swift
//  CagesFarm
//
//  Created by José Mateus Azevedo on 06/04/21.
//

import Foundation
import SpriteKit
import GameplayKit

class InterrupterScene: SKScene {

    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()

    // Scene's components
    private var sprite = SKSpriteNode()
    private var sprites: [SKTexture] = []

    override func sceneDidLoad() {
        setComponent()
        animates()
    }

    private func buildSprite() {
      var frames: [SKTexture] = []

      for index in 0...9 {
        let frame = SKTexture(imageNamed: "light_switch_sprite_0\(index)")
        frames.append(frame)
      }
        sprites = frames
    }

    private func animates() {
        buildSprite()
        let animation = SKAction.animate(with: sprites, timePerFrame: 0.2)
        let quit =  SKAction.run {
            self.quitScene()
        }
        let animate = SKAction.sequence([animation, quit])
        sprite.run(animate)
    }

    /// Draws Components.
    private func setComponent() {
        sprite.texture =  SKTexture(imageNamed: "light_switch_sprite_00")
        sprite.position = CGPoint(x: 0, y: 0)
        sprite.size = CGSize(width: 300, height: 300)
        addChild(sprite)
    }

    func quitScene() {
        SceneCoordinator.coordinator.entryPuzzleScenes["interrupter"] = false
        SceneCoordinator.coordinator.returnToMainScene(view: self.view)
    }
}

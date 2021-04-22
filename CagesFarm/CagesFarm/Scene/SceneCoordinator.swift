//
//  SceneCoordinator.swift
//  CagesFarm
//
//  Created by José Mateus Azevedo on 23/03/21.
//
import SpriteKit

/// Responsible for saving the scenes.
class SceneCoordinator {

    /// SceneCoordinator static instance.
    static var coordinator = SceneCoordinator()
    var gameScene: GameScene?
    var puzzleScene: PuzzleScene?
    var entryPuzzleScenes = ["keyboard" : true, "colors" : true, "interrupter" : true]

    var shouldShouldKeyboardPuzzle: Bool?
    var shouldShowInterrupterScene = false
    var shouldAddKnife = true
    var isFirstTapOnInterruptor = true
    var canLeaveBedroom = false

    func addItemToInventory(item: Items) {
        gameScene?.inventory.addItem(itemName: item)
    }

    func returnToMainScene(view: SKView?) {
        let transition: SKTransition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = SceneCoordinator.coordinator.gameScene!
        scene.anchorPoint = .init(x: 0.5, y: 0.5)
        view?.presentScene(scene, transition: transition)
    }

    func resetCoordinator() {
        SceneCoordinator.coordinator.gameScene = nil
        SceneCoordinator.coordinator.puzzleScene = nil
        SceneCoordinator.coordinator.entryPuzzleScenes =  ["keyboard" : true, "colors" : true, "interrupter" : true]
        SceneCoordinator.coordinator.shouldAddKnife = true
        SceneCoordinator.coordinator.shouldShouldKeyboardPuzzle = nil
        SceneCoordinator.coordinator.shouldShowInterrupterScene = false
        SceneCoordinator.coordinator.isFirstTapOnInterruptor = true
        SceneCoordinator.coordinator.canLeaveBedroom = false

    }
    
}

struct LastInteraction {
    var objectType: InteractableObjects
    var currentAnswer: Int
}

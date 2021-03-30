//
//  SceneCoordinator.swift
//  CagesFarm
//
//  Created by José Mateus Azevedo on 23/03/21.
//

/// Responsible for saving the scenes.
class SceneCoordinator {

    /// SceneCoordinator static instance.
    static var coordinator = SceneCoordinator()
    var gameScene: GameScene?
    var puzzleScene: PuzzleScene?
}

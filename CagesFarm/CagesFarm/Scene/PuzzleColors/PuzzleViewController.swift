//
//  PuzzleViewController.swift
//  CagesFarm
//
//  Created by José Mateus Azevedo on 18/03/21.
//

import UIKit

class PuzzleViewController: UIViewController {

    let contentView = MenuView()

    override func loadView() {
        contentView.playButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        view = contentView

    }

    @objc func play() {

        self.present(GameViewController(), animated: true, completion: nil)

    }

}

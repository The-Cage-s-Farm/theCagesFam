//
//  MenuViewController.swift
//  CagesFarm
//
//  Created by Tales Conrado on 11/03/21.
//

import UIKit

class MenuViewController: UIViewController {
    let contentView = MainMenuView()
    var coordinator: Coordinator?

    override func loadView() {
        contentView.playButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        contentView.configButton.addTarget(self, action: #selector(configurations), for: .touchUpInside)
        contentView.exitButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        view = contentView
    }
    
    @objc func play() {
        let gameViewController = GameViewController()
        gameViewController.modalPresentationStyle = .fullScreen
        self.present(gameViewController, animated: true, completion: nil)
    }

    @objc func close() {
        UIView.animate(withDuration: 2) {
            self.view.alpha = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            exit(1)
        }
    }

    @objc func configurations() {
        coordinator?.showConfigurations()
    }
}

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
        view = contentView
    }
    
    @objc func play() {
       // self.show(GameViewController(), sender: self)
        // let navigation = UINavigationController(rootViewController: GameViewController())
       // self.navigationController?.pushViewController(navigation, animated: true)
        let gameViewController = GameViewController()
        gameViewController.modalPresentationStyle = .fullScreen
        self.present(gameViewController, animated: true, completion: nil)
    }

    @objc func configurations() {
        coordinator?.showConfigurations()
    }

}

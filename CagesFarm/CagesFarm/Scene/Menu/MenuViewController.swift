//
//  MenuViewController.swift
//  CagesFarm
//
//  Created by Tales Conrado on 11/03/21.
//

import UIKit

class MenuViewController: UIViewController {
    
    let contentView = MenuView()

    override func loadView() {
        contentView.playButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        view = contentView

    }


//    override func present(_ viewControllerToPresent: UIViewController,
//                          animated flag: Bool,
//                          completion: (() -> Void)? = nil) {
//      viewControllerToPresent.modalPresentationStyle = .fullScreen
//      super.present(viewControllerToPresent, animated: flag, completion: completion)
//    }

    @objc func play() {
       // self.show(GameViewController(), sender: self)
        // let navigation = UINavigationController(rootViewController: GameViewController())
       // self.navigationController?.pushViewController(navigation, animated: true)
        let gameViewController = GameViewController()
        self.present(gameViewController, animated: true, completion: nil)
        gameViewController.modalPresentationStyle = .fullScreen
        
    }

}


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

    @objc func play() {

        self.present(GameViewController(), animated: true, completion: nil)
        
    }

}

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
        view = contentView
    }
}

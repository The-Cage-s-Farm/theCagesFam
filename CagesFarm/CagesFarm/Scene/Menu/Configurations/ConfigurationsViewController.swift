//
//  ConfigurationsViewController.swift
//  CagesFarm
//
//  Created by Tales Conrado on 23/03/21.
//

import UIKit

class ConfigurationsViewController: UIViewController {

    var coordinator: Coordinator?

    override func loadView() {
        view = ConfigurationView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissTapping))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissTapping() {
        coordinator?.showMainMenu()
    }
}

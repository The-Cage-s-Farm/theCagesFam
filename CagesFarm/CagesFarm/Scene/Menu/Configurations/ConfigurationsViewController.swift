//
//  ConfigurationsViewController.swift
//  CagesFarm
//
//  Created by Tales Conrado on 23/03/21.
//

import UIKit

class ConfigurationsViewController: UIViewController {

    var coordinator: Coordinator?
    let contentView = ConfigurationView()

    override func loadView() {
        view = contentView
        contentView.backButton.addTarget(self, action: #selector(didTapBackButton),
                                         for: .touchUpInside)
    }

    @objc func didTapBackButton() {
        coordinator?.showMainMenu()
    }
}

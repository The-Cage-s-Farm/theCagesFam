//
//  MainCoordinator.swift
//  CagesFarm
//
//  Created by Tales Conrado on 23/03/21.
//

import Foundation

protocol Coordinator {
    func showConfigurations()
    func showMainMenu()
}

class MainCoordinator: Coordinator {

    let menuViewController = MenuViewController()
    let configViewController = ConfigurationsViewController()

    init() {
        menuViewController.coordinator = self
        configViewController.coordinator = self
    }

    func showConfigurations() {
        menuViewController.contentView.prepareForShowingConfigurations()
        configViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.present(configViewController, animated: true)
    }

    func showMainMenu() {
        configViewController.dismiss(animated: true) {
            self.menuViewController.contentView.willReappearFromConfigurations()
        }
    }
}

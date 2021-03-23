//
//  ConfigurationsView.swift
//  CagesFarm
//
//  Created by Tales Conrado on 23/03/21.
//

import UIKit

class ConfigurationView: UIView {

    let cardView: UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = .blue
        return card
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        buildViewHierarchy()
        setupConstraints()
    }

    private func buildViewHierarchy() {
        addSubview(cardView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardView.heightAnchor.constraint(equalToConstant: 320),
            cardView.widthAnchor.constraint(equalToConstant: 400),
            cardView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

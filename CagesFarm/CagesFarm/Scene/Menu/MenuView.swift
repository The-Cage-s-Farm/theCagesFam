//
//  MenuView.swift
//  CagesFarm
//
//  Created by Tales Conrado on 11/03/21.
//

import UIKit

class MenuView: UIView {
    let backgroundImage: UIImageView = {
        let bg = UIImageView()
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.image = UIImage(named: "bg-tree")
        bg.contentMode = .scaleAspectFill
        return bg
    }()
    
    let gameTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "The Cage's Farm"
        title.font = UIFont.monospacedSystemFont(ofSize: 50, weight: .bold)
        title.numberOfLines = 1
        title.textColor = .white
        return title
    }()

    let playButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("PLAY", for: .normal)
        btn.titleLabel?.font = UIFont.monospacedSystemFont(ofSize: 30, weight: .bold)
        btn.backgroundColor = .darkGray
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .black
        buildViewHierarchy()
        setupConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(backgroundImage)
        addSubview(gameTitle)
        addSubview(playButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // BACKGROUND
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // TITLE
            gameTitle.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -24),
            gameTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // PLAY BUTTON
            playButton.topAnchor.constraint(equalTo: centerYAnchor, constant: 24),
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2)
        ])
    }
}

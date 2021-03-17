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
    
    let coverView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 19/255, green: 21/255, blue: 37/255, alpha: 0.8)
        return view
    }()
    
    let gameTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "The Cage's Farm"
        title.font = .pixel(50)
        title.numberOfLines = 1
        title.textColor = .white
        return title
    }()

    let playButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        let image = UIImage(named: "play-button")
        btn.setImage(image, for: .normal)
        return btn
    }()
    
    let configButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        let image = UIImage(named: "config-button")
        btn.setImage(image, for: .normal)
        return btn
    }()
    
    let exitButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        let image = UIImage(named: "exit-button")
        btn.setImage(image, for: .normal)
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
        addSubview(coverView)
        addSubview(gameTitle)
        addSubview(playButton)
        addSubview(configButton)
        addSubview(exitButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // BACKGROUND
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // COVER VIEW
            coverView.topAnchor.constraint(equalTo: topAnchor),
            coverView.leftAnchor.constraint(equalTo: leftAnchor),
            coverView.rightAnchor.constraint(equalTo: rightAnchor),
            coverView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // TITLE
            gameTitle.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -24),
            gameTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // CONFIG BUTTON
            configButton.topAnchor.constraint(equalTo: centerYAnchor, constant: 24),
            configButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // PLAY BUTTON
            playButton.topAnchor.constraint(equalTo: configButton.topAnchor),
            playButton.trailingAnchor.constraint(equalTo: configButton.leadingAnchor, constant: -16),
            
            // EXIT BUTTON
            exitButton.topAnchor.constraint(equalTo: configButton.topAnchor),
            exitButton.leadingAnchor.constraint(equalTo: configButton.trailingAnchor, constant: 16),
            
        ])
    }
}

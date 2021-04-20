//
//  ConfigurationsView.swift
//  CagesFarm
//
//  Created by Tales Conrado on 23/03/21.
//

import UIKit

class ConfigurationView: UIView {

    @UserDefaultsWrapper(key: .isSoundOn, defaultValueForKey: true)
    var isSoundOn: Bool

    @UserDefaultsWrapper(key: .isVibrationOn, defaultValueForKey: true)
    var isVibrationOn: Bool

    let cardView: UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = .configMenuBackground
        card.layer.borderWidth = 1
        card.layer.borderColor = UIColor.white.cgColor
        return card
    }()

    let configurationsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Configurações"
        label.font = .dogicaBold(26)
        label.textColor = .white

        return label
    }()

    let soundLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Som"
        label.font = .dogicaPixel(19)
        label.textColor = .white

        return label
    }()

    let vibrationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vibração"
        label.font = .dogicaPixel(19)
        label.textColor = .white

        return label
    }()

    lazy var vibrationSwitchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = isVibrationOn ? 1 : 0
        let status = button.tag == 1 ? "on" : "off"
        let image = UIImage(named: "config-switch-button-\(status)")
        button.setImage(image, for: .normal)
        button.addTarget(self,
                         action: #selector(toggleVibrationSwitch(sender:)),
                         for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()

    lazy var soundSwitchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = isSoundOn ? 1 : 0
        let status = button.tag == 1 ? "on" : "off"
        let image = UIImage(named: "config-switch-button-\(status)")
        button.setImage(image, for: .normal)
        button.addTarget(self,
                         action: #selector(toggleSoundSwitch(sender:)),
                         for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()

    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        let image = UIImage(named: "config-back-button")
        button.setBackgroundImage(image, for: .normal)
        button.setTitle("Voltar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .dogicaBold(13)
        
        return button
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func toggleVibrationSwitch(sender: UIButton) {
        if sender.tag == 0 {
            let image = UIImage(named: "config-switch-button-on")
            vibrationSwitchButton.setImage(image,
                                                     for: .normal)
            sender.tag = 1
            isVibrationOn = true
            let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .medium)
            impactFeedbackgenerator.prepare()
            impactFeedbackgenerator.impactOccurred()
        } else {
            let image = UIImage(named: "config-switch-button-off")
            vibrationSwitchButton.setImage(image,
                                                     for: .normal)
            sender.tag = 0
            isVibrationOn = false
        }
    }

    @objc func toggleSoundSwitch(sender: UIButton) {
        if sender.tag == 0 {
            let image = UIImage(named: "config-switch-button-on")
            soundSwitchButton.setImage(image, for: .normal)
            sender.tag = 1
            isSoundOn = true
        } else {
            let image = UIImage(named: "config-switch-button-off")
            soundSwitchButton.setImage(image, for: .normal)
            sender.tag = 0
            isSoundOn = false
        }
    }

    // MARK: View Setup
    private func setupView() {
        buildViewHierarchy()
        setupConstraints()
    }

    private func buildViewHierarchy() {
        addSubview(cardView)
        addSubview(configurationsLabel)
        addSubview(soundLabel)
        addSubview(soundSwitchButton)
        addSubview(vibrationLabel)
        addSubview(vibrationSwitchButton)
        addSubview(backButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // CARD VIEW
            cardView.heightAnchor.constraint(equalToConstant: 340),
            cardView.widthAnchor.constraint(equalToConstant: 420),
            cardView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: centerYAnchor),

            // CONFIGURATION TITLE
            configurationsLabel.topAnchor.constraint(equalTo: cardView.topAnchor,
                                                     constant: 32),
            configurationsLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),

            // SOUND
            soundLabel.topAnchor.constraint(equalTo: configurationsLabel.bottomAnchor,
                                            constant: 56),
            soundLabel.leftAnchor.constraint(equalTo: configurationsLabel.leftAnchor),

            // VIBRATION SWITCH
            soundSwitchButton.topAnchor.constraint(equalTo: soundLabel.bottomAnchor,
                                                       constant: 8),
            soundSwitchButton.leftAnchor.constraint(equalTo: soundLabel.leftAnchor),
            soundSwitchButton.widthAnchor.constraint(equalTo: cardView.widthAnchor,
                                                         multiplier: 0.1),

            // VIBRATION
            vibrationLabel.leftAnchor.constraint(equalTo: soundLabel.leftAnchor),
            vibrationLabel.topAnchor.constraint(equalTo: cardView.centerYAnchor,
                                                constant: 32),

            // VIBRATION SWITCH
            vibrationSwitchButton.topAnchor.constraint(equalTo: vibrationLabel.bottomAnchor,
                                                       constant: 8),
            vibrationSwitchButton.leftAnchor.constraint(equalTo: vibrationLabel.leftAnchor),
            vibrationSwitchButton.widthAnchor.constraint(equalTo: cardView.widthAnchor,
                                                         multiplier: 0.1),

            // BACK
            backButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor,
                                               constant: -16),
            backButton.rightAnchor.constraint(equalTo: cardView.rightAnchor,
                                              constant: -16),
            backButton.widthAnchor.constraint(equalTo: cardView.widthAnchor,
                                              multiplier: 0.25)

        ])
    }
}

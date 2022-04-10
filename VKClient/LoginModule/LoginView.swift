//
//  LoginView.swift
//  VKClient
//
//  Created by Alex on 30.03.2022.
//

import UIKit

final class LoginView: UIView {

    //MARK: - Public property
    
    lazy var authButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Авторизоваться", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor = UIColor(named: CustomColors.activeElements.rawValue)
        button.layer.cornerRadius = 12
        return button
    }()

    //MARK: - Initialisation

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    //MARK: - Life cycle

    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
}

//MARK: - Private methods

extension LoginView {
    private func setupUI() {
        backgroundColor = .systemBackground
        addSubview(authButton)

        NSLayoutConstraint.activate([authButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     authButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     authButton.widthAnchor.constraint(equalToConstant: bounds.width / 2),
                                     authButton.heightAnchor.constraint(equalToConstant: 53)])
    }
}


//
//  File.swift
//  VKClient
//
//  Created by Alex on 03.04.2022.
//

import UIKit

final class CustomFiledButton: UIView {

    //MARK: - ImagesButton Initialisation

    enum ImagesButton {
        case heart
        case comment
        case views

        func setImage() -> String {
            switch self {
            case .heart:
                return "heart"
            case .comment:
                return "bubble.left"
            case .views:
                return "eye"
            }
        }
    }

    lazy var backroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: CustomColors.customBackround.rawValue)
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(named: CustomColors.textColor.rawValue)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    //MARK: - Initialisation

    init(frame: CGRect, imageName: ImagesButton, count: String) {
        super.init(frame: frame)
        button.setImage(UIImage(systemName: imageName.setImage()), for: .normal)
        button.setTitle(count, for: .normal)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private methods

extension CustomFiledButton {
    private func configureView() {
        addSubview(backroundView)
        backroundView.addSubview(button)

        NSLayoutConstraint.activate([backroundView.topAnchor.constraint(equalTo: topAnchor),
                                     backroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     backroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     backroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     backroundView.heightAnchor.constraint(equalToConstant: 34),
                                     
                                     button.topAnchor.constraint(equalTo: backroundView.topAnchor, constant: 4),
                                     button.leadingAnchor.constraint(equalTo: backroundView.leadingAnchor, constant: 6),
                                     button.trailingAnchor.constraint(equalTo: backroundView.trailingAnchor, constant: -6),
                                     button.bottomAnchor.constraint(equalTo: backroundView.bottomAnchor, constant: -4)])
    }
}

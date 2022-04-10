//
//  AuthorizationView.swift
//  VKClient
//
//  Created by Alex on 25.03.2022.
//

import UIKit
import WebKit

final class AuthenticationView: UIView {

    //MARK: - Public property
    
    lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        config.websiteDataStore = .nonPersistent()
        let view = WKWebView(frame: .zero, configuration: config)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = UIColor(named: CustomColors.activeElements.rawValue)
        return indicator
    }()

    //MARK: - Initialisation

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("dealloc \(self)")
    }

    //MARK: - Life cycle


    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
}

//MARK: - Private methods

extension AuthenticationView {
    private func setupUI() {
        backgroundColor = .systemBackground
        addSubview(webView)
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([webView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                                     webView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     webView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     webView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
                                    ])
    }
}

//
//  AuthorizationViewController.swift
//  VKClient
//
//  Created by Alex on 25.03.2022.
//

import UIKit
import WebKit

final class AuthenticationViewController: UIViewController {

    //MARK: - Private property

    private let viewModel: AuthenticationViewModel

    private lazy var authenticationView: AuthenticationView = {
        let view = AuthenticationView()
        return view
    }()

    //MARK: - Initialisation

    init(viewModel: AuthenticationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Life cycle

    override func loadView() {
        view = authenticationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

//MARK: - Private methods

extension AuthenticationViewController {
    private func configureView() {
        authenticationView.webView.navigationDelegate = self
        guard let urlOAuth = URL(string: "https://oauth.vk.com/authorize?client_id=8116211&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=friends,wall,offline,groups&response_type=token&v=5.131") else { return }
        authenticationView.webView.load(URLRequest(url: urlOAuth))
    }
}

//MARK: - WKNavigationDelegate

extension AuthenticationViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else { return }
        if url.absoluteString.contains("access_token=") {
            guard let token = url.absoluteString.components(separatedBy: "access_token=").last?.components(separatedBy: "&").first else { return }
            decisionHandler(.cancel)
            print(token)
            viewModel.saveToken(with: KeyToken.key, token: token)

            dismiss(animated: true) {
                self.viewModel.didAuthenticationpassed()
            }
            return
        } else {
            if url.absoluteString.contains("error") {
                webView.reload()
            }
            decisionHandler(.allow)
        }
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        authenticationView.activityIndicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        authenticationView.activityIndicator.stopAnimating()
    }
}


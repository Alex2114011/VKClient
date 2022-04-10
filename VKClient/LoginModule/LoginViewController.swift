//
//  LoginScreenViewController.swift
//  VKClient
//
//  Created by Alex on 27.03.2022.
//

import UIKit

final class LoginViewController: UIViewController {

    //MARK: - Private property

    private lazy var loginView: LoginView = {
        let view = LoginView()
        view.authButton.addTarget(self, action: #selector(didTapAuthButton), for: .touchUpInside)
        return view
    }()

    private let viewModel: LoginViewModel

    //MARK: - Initialisation

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Life cycle

    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    deinit {
        print("dealloc \(self)")
    }
}

//MARK: - Public methods

extension LoginViewController {
    @objc private func didTapAuthButton() {
        viewModel.goToAuthenticationViewController()
    }
}

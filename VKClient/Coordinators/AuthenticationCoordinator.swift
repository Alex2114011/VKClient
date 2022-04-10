//
//  AuthenticationCoordinator.swift
//  VKClient
//
//  Created by Alex on 30.03.2022.
//

import UIKit

protocol AuthenticationCoordinator: AnyObject {
    func showLoginViewController()
    func showAuthViewController()
    func didSuccessLogin(from: AuthenticationViewModelImpl)
    var coordinatorDidAuthenticate:((AuthenticationCoordinatorImp) -> ())? { get set }
}

final class AuthenticationCoordinatorImp: Coordinator {

    //MARK: - Public property

    var coordinatorDidAuthenticate:((AuthenticationCoordinatorImp) -> ())?
    var navigationController: UINavigationController

    //MARK: - Initialisation

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    //MARK: - Public methods
    
    func start() {
        showLoginViewController()
    }

    deinit {
        print("dealloc \(self)")
    }
}

//MARK: - AuthenticationCoordinator

extension AuthenticationCoordinatorImp: AuthenticationCoordinator {
    func showLoginViewController() {
        let loginViewModel = LoginViewModelImpl()
        loginViewModel.authCoordinator = self
        let loginVC = LoginViewController(viewModel: loginViewModel)
        navigationController.pushViewController(loginVC, animated: true)
        
    }

    func showAuthViewController() {
        let keyChain = KeychainServiceImpl()
        let authViewModel = AuthenticationViewModelImpl(storage: keyChain)
        let authVC = AuthenticationViewController(viewModel: authViewModel)
        navigationController.present(authVC, animated: true, completion: nil)
        didSuccessLogin(from: authViewModel)
    }

    func didSuccessLogin(from: AuthenticationViewModelImpl) {
        from.authenticationPassed = { [weak self] in
            guard let self = self else { return }
            self.coordinatorDidAuthenticate?(self)
        }
    }


}

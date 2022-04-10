//
//  LoginViewModel.swift
//  VKClient
//
//  Created by Alex on 30.03.2022.
//

import Foundation

protocol LoginViewModel {
    func goToAuthenticationViewController()
}

final class LoginViewModelImpl {

     weak var authCoordinator: AuthenticationCoordinator?
}

//MARK: - LoginViewModel

extension LoginViewModelImpl: LoginViewModel {
    func goToAuthenticationViewController() {
        authCoordinator?.showAuthViewController()
    }
}

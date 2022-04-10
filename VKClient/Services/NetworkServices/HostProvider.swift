//
//  HostProvider.swift
//  StocksLesson10
//
//  Created by Alex on 25.03.2022.
//

import Foundation

protocol HostProvider {
    func getHostURL() -> URL
}

final class HostProviderImpl {
    private enum Host {
        case world
    }

    private var host: Host = .world
}

extension HostProviderImpl: HostProvider {
    func getHostURL() -> URL {
        switch host {
        case .world:
            return URL(string: "https://api.vk.com/method/")!
        }
    }
}

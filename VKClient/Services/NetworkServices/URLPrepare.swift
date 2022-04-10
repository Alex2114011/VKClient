//
//  URLPrepare.swift
//  StocksLesson10
//
//  Created by Alex on 25.03.2022.
//

import Foundation

protocol URLPrepare {

    func prepareSearchRequest(url: URL,
                              parameters: [String: String]?,
                              httpMethod: HTTPMethod,
                              headerParameters: [String: String]?,
                              data: Data?) -> URLRequest?

}

final class URLPrepareImpl {

    //MARK: - Private property

    private let hostProvider: HostProvider

    //MARK: - Initialisation

     init(hostProvider: HostProvider) {
        self.hostProvider = hostProvider
    }
}

extension URLPrepareImpl: URLPrepare {

    func prepareSearchRequest(url: URL,
                              parameters: [String: String]?,
                              httpMethod: HTTPMethod,
                              headerParameters: [String: String]?,
                              data: Data?) -> URLRequest? {

        let urlWithHost = hostProvider.getHostURL().appendingPathComponent(url.absoluteString)

        guard var components = URLComponents(url: urlWithHost,
                                             resolvingAgainstBaseURL: true) else {
            return nil
        }

        if let parameters = parameters {
            components.queryItems = parameters.map({ (key: String, value: String) in
                URLQueryItem(name: key, value: value)
            })
        }

        guard let finalURL = components.url else {
            return nil
        }
        var request = URLRequest(url: finalURL)

        if let headerParams = headerParameters {
            for (key, value) in headerParams {
                request.addValue(key, forHTTPHeaderField: value)
            }
        }

        request.httpMethod = httpMethod.rawValue.uppercased()
        request.httpBody = data
        return request
    }
}

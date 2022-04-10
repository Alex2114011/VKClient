//
//  URLProvider.swift
//  StocksLesson10
//
//  Created by Alex on 25.03.2022.
//

import Foundation

protocol URLProvider {
    var getNewsFeed: URL { get }
}

final class URLProviderImpl {

}

//MARK: - URLProvider

extension URLProviderImpl: URLProvider {
    var getNewsFeed: URL {
        return URL(string: "newsfeed.get")!
    }
}

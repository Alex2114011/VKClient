//
//  NetworkError.swift
//  VKClient
//
//  Created by Alex on 25.03.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case responseDecodingError
    case connectionError
}

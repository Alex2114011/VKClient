//
//  NewsFeedResponse.swift
//  VKClient
//
//  Created by Alex on 01.04.2022.
//

import Foundation

struct NewsFeedResponse: Responsable {
    let array: NewsFeedModelRaw

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let values = try container.decode(NewsFeedModelRaw.self)
        array = values
    }
}

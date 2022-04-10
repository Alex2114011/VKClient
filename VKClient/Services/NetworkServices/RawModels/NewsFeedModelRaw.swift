//
//  File1.swift
//  VKClient
//
//  Created by Alex on 01.04.2022.
//

import Foundation

// MARK: - NewsFeedModelRaw
struct NewsFeedModelRaw: Codable {
    let response: Response?

        enum CodingKeys: String, CodingKey {
            case response = "response"
        }
    }

    // MARK: - Response
    struct Response: Codable {
        let items: [ResponseItem]?
        let groups: [Group]?
        let nextFrom: String?

        enum CodingKeys: String, CodingKey {
            case items = "items"
            case groups = "groups"
            case nextFrom = "next_from"
        }
    }

    // MARK: - Group
    struct Group: Codable {
        let id: Int?
        let name: String?
        let screenName: String?
        let photo50: String?


        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case screenName = "screen_name"
            case photo50 = "photo_50"
        }
    }

    // MARK: - ResponseItem
    struct ResponseItem: Codable {
        let sourceID: Int?
        let date: Int?
        let text: String?
        let attachments: [Attachment]?
        let comments: Comments?
        let likes: PurpleLikes?
        let views: Views?
        let copyHistory: [CopyHistory]?

        enum CodingKeys: String, CodingKey {
            case sourceID = "source_id"
            case date = "date"
            case text = "text"
            case attachments = "attachments"
            case comments = "comments"
            case likes = "likes"
            case views = "views"
            case copyHistory = "copy_history"
        }
    }

    // MARK: - Attachment
    struct Attachment: Codable {
        let photo: Photo?
    }

    // MARK: - Photo
    struct Photo: Codable {
        let sizes: [Size]?


        enum CodingKeys: String, CodingKey {
            case sizes = "sizes"

        }
    }

    // MARK: - Size
    struct Size: Codable {
        let height: Int?
        let url: String?
        let width: Int?

        enum CodingKeys: String, CodingKey {
            case height = "height"
            case url = "url"
            case width = "width"
        }
    }

    // MARK: - Comments
    struct Comments: Codable {
        let count: Int?

        enum CodingKeys: String, CodingKey {
            case count = "count"
        }
    }

    // MARK: - CopyHistory
    struct CopyHistory: Codable {
        let attachments: [Attachment]?

        enum CodingKeys: String, CodingKey {
            case attachments = "attachments"
        }
    }


    // MARK: - PurpleLikes
    struct PurpleLikes: Codable {
        let count: Int?

        enum CodingKeys: String, CodingKey {
            case count = "count"
        }
    }

    // MARK: - Views
    struct Views: Codable {
        let count: Int?

        enum CodingKeys: String, CodingKey {
            case count = "count"
        }
    }

    // MARK: - OnlineInfo
    struct OnlineInfo: Codable {
        let visible: Bool?

        enum CodingKeys: String, CodingKey {
            case visible = "visible"

        }
    }


//
//  GiF.swift
//  GIPHYClient
//
//  Created by Bryan A Bolivar M on 2/22/19.
//  Copyright © 2019 BolivarBryan. All rights reserved.
//

import Foundation

struct GiphyItem: Codable {
    let type: String
    let id: String
    let slug: String
    let url: String
    let username: String
    let source: String
    let rating: String
    let image: GiphyImage
    let title: String
    let score: Int

    enum CodingKeys: String, CodingKey {
        case type, id, slug, url
        case username, source, rating
        case image = "images"
        case title
        case score = "_score"
    }
}

struct GiphyImage: Codable {
    let original: Image
    let preview: Image

    enum CodingKeys: String, CodingKey {
        case original
        case preview = "preview_gif"
    }
}

struct Image: Codable {
    let urlString: String

    var url: URL? {
        return URL(string: urlString)
    }

    enum CodingKeys: String, CodingKey {
        case urlString = "url"
    }
}

struct Pagination: Codable {
    let totalCount: Int
    let count: Int

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count
    }
}

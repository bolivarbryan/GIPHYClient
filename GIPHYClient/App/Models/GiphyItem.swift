//
//  GiF.swift
//  GIPHYClient
//
//  Created by Bryan A Bolivar M on 2/22/19.
//  Copyright © 2019 BolivarBryan. All rights reserved.
//

import Foundation

struct GiphyItem: Codable {
    let id: String
    let image: GiphyImage

    enum CodingKeys: String, CodingKey {
        case id
        case image = "images"
    }
}

struct GiphyImage: Codable {
    let original: Image
    let preview: Image

    enum CodingKeys: String, CodingKey {
        case original
        case preview = "preview_gif"
    }

    var dataRepresentation: Data? {
        let data = try? JSONEncoder().encode(self)
        return data
    }
}

struct Image: Codable {
    let urlString: String

    var url: URL? {
        return URL(string: urlString)
    }

    var data: Data? = nil

    enum CodingKeys: String, CodingKey {
        case urlString = "url"
    }

    init?(from dictionary: [String: Any]) {
        self.urlString = dictionary["url"] as? String ?? ""
        self.data = dictionary["data"] as? Data
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

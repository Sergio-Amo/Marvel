//
//  MarvelResponse.swift
//  Marvel
//
//  Created by Sergio Amo on 22/2/24.
//

import Foundation

// MARK: - Main response
struct MarvelResponse: Codable {
    let code: Int // Status code
    let data: DataClass?
}

// MARK: - DataClass
struct  DataClass: Codable {
    let offset, total, count: Int
    let results: [MarvelItem]?
}

// MARK: - Result
struct MarvelItem: Codable, Identifiable {
    let id: Int?
    let name: String?  // Characters have name instead of title
    let title: String? // Series have title instead of name
    let description: String?
    let thumbnail: Thumbnail?
    // The things one must to to have an optional value that doesn't need to be explicity initialized...
    init(id: Int?, name: String? = nil, title: String? = nil, description: String?, thumbnail: Thumbnail?) {
        self.id = id
        self.name = name
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
    }
    
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String?
    // Extension as string instead of enum so it'll work fine even if at some point they insert other formats like heic
    // Shouldn't be a problem as far as xCode support the format.
    let thumbnailExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
    var fullPath: URL? {
        guard let path,
              let thumbnailExtension else {
            return nil
        }
        // Returns the string as a https url
        return URL(string: "\(path).\(thumbnailExtension)")?.upgradeUrlScheme
    }
}

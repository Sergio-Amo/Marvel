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
    /// -  Returns: url with the image EXTENSION NOT INCLUDED, protocol may not be https (using fullPath might be what you want)
    let path: String?
    // Extension as string instead of enum so it'll work fine even if at some point they insert other formats like heic
    // Shouldn't be a problem as far as xCode support the format.
    /// -  Returns: the extension of the imahe
    let thumbnailExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
    /// -  Returns: https url with the image including its extension
    var fullPath: URL? {
        guard let path,
              let thumbnailExtension else {
            return nil
        }
        return URL(string: "\(path).\(thumbnailExtension)")?.upgradeUrlScheme
    }
    /// -  Returns: https url with the image in landscape mode including its extension
    var fullPathLandscape: URL? {
        guard let path,
              let thumbnailExtension else {
            return nil
        }
        return URL(string: "\(path)/landscape_incredible.\(thumbnailExtension)")?.upgradeUrlScheme
    }
    /// -  Returns: https url with the image in portrait mode including its extension
    var fullPathPortrait: URL? {
        guard let path,
              let thumbnailExtension else {
            return nil
        }
        return URL(string: "\(path)/portrait_incredible.\(thumbnailExtension)")?.upgradeUrlScheme
    }
}

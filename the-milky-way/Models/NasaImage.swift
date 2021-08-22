//
//  NasaImage.swift
//  the-milky-way
//
//  Created by Steeve Fong on 2021/08/21.
//

import Foundation

// MARK: - NasaImage
struct NasaImage: Decodable {
    let href: String
    let links: [Link]
    let data: [NasaImageData]
}

// MARK: - NasaImageData
struct NasaImageData: Decodable {
    let title, imageDescription, center, nasaID: String
    let photographer: String?
    let mediaType: MediaType
    let keywords: [String]?
    let dateCreated: Date?
    
    enum CodingKeys: String, CodingKey {
        case title, photographer, keywords, center
        case imageDescription = "description"
        case mediaType = "media_type"
        case dateCreated = "date_created"
        case nasaID = "nasa_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        photographer = try? container.decode(String.self, forKey: .photographer)
        keywords = try? container.decode([String].self, forKey: .keywords)
        center = try container.decode(String.self, forKey: .center)
        imageDescription = try container.decode(String.self, forKey: .imageDescription)
        mediaType = try container.decode(MediaType.self, forKey: .mediaType)
        nasaID = try container.decode(String.self, forKey: .nasaID)
        
        let dateString = try container.decode(String.self, forKey: .dateCreated)
        dateCreated = dateString.iso8601ToDate()
    }
}

// MARK: - Link
struct Link: Decodable {
    let href, rel, render: String?
}

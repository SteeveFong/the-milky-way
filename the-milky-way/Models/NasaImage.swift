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

// MARK: - Datum
struct NasaImageData: Decodable {
    let title, photographer, imageDescription, mediaType, center, nasaID: String
    let keywords: [String]
    let dateCreated: Date
    
    enum CodingKeys: String, CodingKey {
        case title, photographer, keywords, center
        case imageDescription = "description"
        case mediaType = "media_type"
        case dateCreated = "date_created"
        case nasaID = "nasa_id"
    }
}

// MARK: - Link
struct Link: Decodable {
    let href, rel, render: String
}

//
//  MediaType.swift
//  the-milky-way
//
//  Created by Steeve Fong on 2021/08/22.
//

import Foundation

enum MediaType: Decodable {
    case image
    case unknown(value: String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let valueString = try? container.decode(String.self)
        
        switch valueString?.lowercased() {
        case "image":
            self = .image
        default:
            self = .unknown(value: valueString ?? "unknown")
        }
    }
}

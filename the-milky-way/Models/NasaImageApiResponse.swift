//
//  NasaImages.swift
//  the-milky-way
//
//  Created by Steeve Fong on 2021/08/21.
//

import Foundation

struct NasaImageApiResponse: Decodable {
    let collection: NasaImageCollection
}

struct NasaImageCollection: Decodable {
    let items: [NasaImage]
    let links: [Link]
    
    func hasPrevious() -> Bool {
        return links.contains { (link) -> Bool in
            link.rel == "prev"
        }
    }
    
    func hasNext() -> Bool {
        return links.contains { (link) -> Bool in
            link.rel == "next"
        }
    }
}

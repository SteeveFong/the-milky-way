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
}

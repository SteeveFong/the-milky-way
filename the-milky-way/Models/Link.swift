//
//  Link.swift
//  the-milky-way
//
//  Created by Steeve Fong on 2021/08/25.
//

import Foundation

struct Link: Decodable {
    let href, rel, render, prompt: String?
}

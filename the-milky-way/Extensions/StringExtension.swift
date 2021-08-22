//
//  StringExtension.swift
//  the-milky-way
//
//  Created by Steeve Fong on 2021/08/22.
//

import Foundation

extension String {
    func iso8601ToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ssZ"
        return dateFormatter.date(from: self)
    }
}

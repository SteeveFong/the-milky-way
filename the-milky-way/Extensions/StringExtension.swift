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
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return dateFormatter.date(from: self)
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

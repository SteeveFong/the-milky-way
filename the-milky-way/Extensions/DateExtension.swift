//
//  DateExtension.swift
//  the-milky-way
//
//  Created by Steeve Fong on 2021/08/24.
//

import Foundation

extension Date {
    func displayImageDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"
        
        return formatter.string(from: self)
    }
}

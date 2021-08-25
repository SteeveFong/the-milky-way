//
//  MilkyWayError.swift
//  the-milky-way
//
//  Created by Steeve Fong on 2021/08/21.
//

import Foundation

enum MilkyWayError: Error {
    case noData
    case other(String?)
}

//MARK: - MilkyWayErrorExtension
extension MilkyWayError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .noData:
            return "noDataError".localized
        case .other(let description):
            return description ?? "unknownError".localized
        }
    }
}

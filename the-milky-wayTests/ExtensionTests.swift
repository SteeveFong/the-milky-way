//
//  ExtensionTests.swift
//  TheMilkyWayTests
//
//  Created by Steeve Fong on 2021/08/21.
//

import XCTest
@testable import the_milky_way

class ExtensionTests: XCTestCase {
    func testDisplayImageDateInProperFormat() throws {
        let test = "2002-03-20T00:00:00Z".iso8601ToDate()
        let test2 = "2009-12-21T00:00:00Z".iso8601ToDate()
        
        XCTAssertEqual(test!.displayImageDate(), "20 Mar, 2002")
        XCTAssertEqual(test2!.displayImageDate(), "21 Dec, 2009")
    }
    
    func testLocalizedExtensionn() {
        let test = "noDataError".localized
        let test2 = "unknownError".localized
        
        XCTAssertEqual(test, "It seems there is no data present for this search.")
        XCTAssertEqual(test2, "An unknown error has occurred.")
    }
}

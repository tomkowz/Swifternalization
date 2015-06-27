//
//  RegexTests.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest
import Swifternalization

class RegexTests: XCTestCase {

    func testRegexWorks() {
        let matches = Regex.matchesInString("ie:%d=2", pattern: "^(ie:)")
        XCTAssertTrue(matches.count == 1, "Should found 1 match")
    }
    
    func testRegexShouldFindTextWithoutExpression() {
        let match = Regex.firstMatchInString("cars{%d=1}", pattern: "(.*)(?=\\{)")
        XCTAssertTrue(match != nil, "Match should not be nil")
        XCTAssertEqual(match!, "cars", "Should be equal 'cars'")
    }
}

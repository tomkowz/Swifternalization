//
//  RegexExpressionParserTests.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest

class RegexExpressionParserTests: XCTestCase {

    func testMatcher1() {
        let matcher = RegexExpressionParser("exp:[2-4]").parse() as! RegexExpressionMatcher
        XCTAssertEqual(matcher.pattern, "[2-4]", "should be [2-4]")
    }
    
    func testMatcher2() {
        let matcher = RegexExpressionParser("exp:[a-z]").parse() as! RegexExpressionMatcher
        XCTAssertEqual(matcher.pattern, "[a-z]", "should be [a-z]")
    }
}

//
//  RegexExpressionMatcherTests.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest

class RegexExpressionMatcherTests: XCTestCase {
    
    func testValidation1() {
        let matcher = InequalityExpressionParser("ie:x=3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.validate("3"), "should be true")
        XCTAssertFalse(matcher.validate("5"), "should be true")
    }
    
    func testValidation2() {
        let matcher = InequalityExpressionParser("ie:x<=3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.validate("3"), "should be true")
        XCTAssertTrue(matcher.validate("2"), "should be true")
    }
    
    func testValidation3() {
        let matcher = InequalityExpressionParser("ie:x>=3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.validate("3"), "should be true")
        XCTAssertTrue(matcher.validate("4"), "should be true")
    }
    
    func testValidation4() {
        let matcher = InequalityExpressionParser("ie:x>3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.validate("4"), "should be true")
        XCTAssertFalse(matcher.validate("3"), "should be true")
    }
    
    func testValidation5() {
        let matcher = InequalityExpressionParser("ie:x<3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.validate("2"), "should be true")
        XCTAssertFalse(matcher.validate("3"), "should be true")
    }
}

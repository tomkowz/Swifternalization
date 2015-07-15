//
//  InequalityExtendedExpressionMatcherTests.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest
import Swifternalization

class InequalityExtendedExpressionMatcherTests: XCTestCase {
    
    func testValidation1() {
        let matcher = InequalityExtendedExpressionParser("iex:4<x<6").parse() as! InequalityExtendedExpressionMatcher
        XCTAssertTrue(matcher.validate("5"), "should be true")
        XCTAssertFalse(matcher.validate("4"), "should be false")
        XCTAssertFalse(matcher.validate("6"), "should be false")
    }
    
    func testValidation2() {
        let matcher = InequalityExtendedExpressionParser("iex:4<=x<10").parse() as! InequalityExtendedExpressionMatcher
        XCTAssertTrue(matcher.validate("4"), "should be true")
        XCTAssertFalse(matcher.validate("10"), "should be false")
        XCTAssertFalse(matcher.validate("11"), "should be false")
    }
    
    func testValidation3() {
        let matcher = InequalityExtendedExpressionParser("iex:4>x<10").parse() as! InequalityExtendedExpressionMatcher
        XCTAssertTrue(matcher.validate("3"), "should be true")
        XCTAssertFalse(matcher.validate("5"), "should be false")
        XCTAssertFalse(matcher.validate("11"), "should be false")
    }
    
    func testValidation4() {
        let matcher = InequalityExtendedExpressionParser("iex:4=x=10").parse() as! InequalityExtendedExpressionMatcher
        XCTAssertFalse(matcher.validate("4"), "should be false")
        XCTAssertFalse(matcher.validate("10"), "should be false")
        XCTAssertFalse(matcher.validate("8"), "should be false")
    }
}

//
//  InequalityExpressionParser.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest
import Swifternalization

class InequalityExpressionParserTests: XCTestCase {

    var matcher: InequalityExpressionMatcher!
    
    override func setUp() {
        super.setUp()
    }
    
    func testCorrectlyParsedExpression() {
        matcher = InequalityExpressionParser("ie:%d=3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.valueType == .Integer, "value type should be integer")
        XCTAssertTrue(matcher.sign == .Equal, "sign should be equality")
        XCTAssertTrue(matcher.value == 3, "value should be 3")
    }
    
    func testShouldBeEqual() {
        matcher = InequalityExpressionParser("ie:%d=3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.validate("3"), "should be true")
        XCTAssertFalse(matcher.validate("5"), "should be true")
    }
    
    func testShouldBeLessThanOrEqual() {
        matcher = InequalityExpressionParser("ie:%d<=3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.validate("3"), "should be true")
        XCTAssertTrue(matcher.validate("2"), "should be true")
    }
    
    func testShouldBeGreaterThanOrEqual() {
        matcher = InequalityExpressionParser("ie:%d>=3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.validate("3"), "should be true")
        XCTAssertTrue(matcher.validate("4"), "should be true")
    }
    
    func testShouldBeGreaterThan() {
        matcher = InequalityExpressionParser("ie:%d>3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.validate("4"), "should be true")
        XCTAssertFalse(matcher.validate("3"), "should be true")
    }
    
    func testShouldBeLessThan() {
        matcher = InequalityExpressionParser("ie:%d<3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.validate("2"), "should be true")
        XCTAssertFalse(matcher.validate("3"), "should be true")
    }
}

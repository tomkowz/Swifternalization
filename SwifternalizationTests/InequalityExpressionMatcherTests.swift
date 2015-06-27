//
//  InequalityExpressionMatcherTests.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest

class InequalityExpressionMatcherTests: XCTestCase {

    func testParser1() {
        let matcher = InequalityExpressionParser("ie:%d=3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.valueType == .Integer, "should be integer")
        XCTAssertTrue(matcher.sign == .Equal, "should be equal")
        XCTAssertTrue(matcher.value == 3, "should be 3")
    }
    
    func testParser2() {
        let matcher = InequalityExpressionParser("ie:%d>3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.valueType == .Integer, "should be integer")
        XCTAssertTrue(matcher.sign == .GreaterThan, "should be equal")
        XCTAssertTrue(matcher.value == 3, "should be 3")
    }
    
    func testParser3() {
        let matcher = InequalityExpressionParser("ie:%d<3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.valueType == .Integer, "should be integer")
        XCTAssertTrue(matcher.sign == .LessThan, "should be equal")
        XCTAssertTrue(matcher.value == 3, "should be 3")
    }
    
    func testParser4() {
        let matcher = InequalityExpressionParser("ie:%d<=3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.valueType == .Integer, "should be integer")
        XCTAssertTrue(matcher.sign == .LessThanOrEqual, "should be equal")
        XCTAssertTrue(matcher.value == 3, "should be 3")
    }
    
    func testParser5() {
        let matcher = InequalityExpressionParser("ie:%d>=3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.valueType == .Integer, "should be integer")
        XCTAssertTrue(matcher.sign == .GreaterThanOrEqual, "should be equal")
        XCTAssertTrue(matcher.value == 3, "should be 3")
    }
}

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

    func testParser1() {
        let matcher = InequalityExpressionParser("ie:x=3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.sign == .Equal, "should be equal")
        XCTAssertTrue(matcher.value == 3, "should be 3")
    }
    
    func testParser2() {
        let matcher = InequalityExpressionParser("ie:x>3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.sign == .GreaterThan, "should be greater than")
        XCTAssertTrue(matcher.value == 3, "should be 3")
    }
    
    func testParser3() {
        let matcher = InequalityExpressionParser("ie:x<3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.sign == .LessThan, "should be less than")
        XCTAssertTrue(matcher.value == 3, "should be 3")
    }
    
    func testParser4() {
        let matcher = InequalityExpressionParser("ie:x<=3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.sign == .LessThanOrEqual, "should be less than or equal")
        XCTAssertTrue(matcher.value == 3, "should be 3")
    }
    
    func testParser5() {
        let matcher = InequalityExpressionParser("ie:x>=3").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.sign == .GreaterThanOrEqual, "should be greater than or equal")
        XCTAssertTrue(matcher.value == 3, "should be 3")
    }
    
    func testParser6() {
        let matcher = InequalityExpressionParser("ie:x=11").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.sign == .Equal, "should be equal")
        XCTAssertTrue(matcher.value == 11, "should be 11")
    }
    
    func testParser7() {
        let matcher = InequalityExpressionParser("ie:x=-5").parse() as! InequalityExpressionMatcher
        XCTAssertTrue(matcher.sign == .Equal, "should be equal")
        XCTAssertTrue(matcher.value == -5, "should be -5")
    }
}

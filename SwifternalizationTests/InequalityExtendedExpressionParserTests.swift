//
//  InequalityExtendedExpressionParserTests.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest

class InequalityExtendedExpressionParserTests: XCTestCase {
    
    func testMatcher1() {
        let matcher = InequalityExtendedExpressionParser("iex:4<%d<10").parse() as! InequalityExtendedExpressionMatcher
        XCTAssertEqual(matcher.leftMatcher.valueType, .Integer, "should be integer")
        XCTAssertEqual(matcher.leftMatcher.sign, .GreaterThan, "should be less than")
        XCTAssertEqual(matcher.leftMatcher.value, 4, "should be 4")
        
        XCTAssertEqual(matcher.rightMatcher.valueType, .Integer, "should be integer")
        XCTAssertEqual(matcher.rightMatcher.sign, .LessThan, "should be less than")
        XCTAssertEqual(matcher.rightMatcher.value, 10, "should be 10")
    }
    
    func testMatcher2() {
        let matcher = InequalityExtendedExpressionParser("iex:4<=%d<=10").parse() as! InequalityExtendedExpressionMatcher
        XCTAssertEqual(matcher.leftMatcher.valueType, .Integer, "should be integer")
        XCTAssertEqual(matcher.leftMatcher.sign, .GreaterThanOrEqual, "should be less than")
        XCTAssertEqual(matcher.leftMatcher.value, 4, "should be 4")
        
        XCTAssertEqual(matcher.rightMatcher.valueType, .Integer, "should be integer")
        XCTAssertEqual(matcher.rightMatcher.sign, .LessThanOrEqual, "should be less than")
        XCTAssertEqual(matcher.rightMatcher.value, 10, "should be 10")
    }
    
    func testMatcher3() {
        let matcher = InequalityExtendedExpressionParser("iex:4>=%d>=10").parse() as! InequalityExtendedExpressionMatcher
        XCTAssertEqual(matcher.leftMatcher.valueType, .Integer, "should be integer")
        XCTAssertEqual(matcher.leftMatcher.sign, .LessThanOrEqual, "should be less than")
        XCTAssertEqual(matcher.leftMatcher.value, 4, "should be 4")
        
        XCTAssertEqual(matcher.rightMatcher.valueType, .Integer, "should be integer")
        XCTAssertEqual(matcher.rightMatcher.sign, .GreaterThanOrEqual, "should be less than")
        XCTAssertEqual(matcher.rightMatcher.value, 10, "should be 10")
    }
    
    func testMatcher4() {
        let matcher = InequalityExtendedExpressionParser("iex:4>%d>10").parse() as! InequalityExtendedExpressionMatcher
        XCTAssertEqual(matcher.leftMatcher.valueType, .Integer, "should be integer")
        XCTAssertEqual(matcher.leftMatcher.sign, .LessThan, "should be less than")
        XCTAssertEqual(matcher.leftMatcher.value, 4, "should be 4")
        
        XCTAssertEqual(matcher.rightMatcher.valueType, .Integer, "should be integer")
        XCTAssertEqual(matcher.rightMatcher.sign, .GreaterThan, "should be less than")
        XCTAssertEqual(matcher.rightMatcher.value, 10, "should be 10")
    }
    
    func testMatcher5() {
        let matcher = InequalityExtendedExpressionParser("iex:4>=%d<10").parse() as! InequalityExtendedExpressionMatcher
        XCTAssertEqual(matcher.leftMatcher.valueType, .Integer, "should be integer")
        XCTAssertEqual(matcher.leftMatcher.sign, .LessThanOrEqual, "should be less than")
        XCTAssertEqual(matcher.leftMatcher.value, 4, "should be 4")
        
        XCTAssertEqual(matcher.rightMatcher.valueType, .Integer, "should be integer")
        XCTAssertEqual(matcher.rightMatcher.sign, .LessThan, "should be less than")
        XCTAssertEqual(matcher.rightMatcher.value, 10, "should be 10")
    }
    
    func testMatcher6() {
        let matcher = InequalityExtendedExpressionParser("iex:-4<=%d<-10").parse() as! InequalityExtendedExpressionMatcher
        XCTAssertEqual(matcher.leftMatcher.valueType, .Integer, "should be integer")
        XCTAssertEqual(matcher.leftMatcher.sign, .LessThanOrEqual, "should be less than")
        XCTAssertEqual(matcher.leftMatcher.value, -4, "should be -4")
        
        XCTAssertEqual(matcher.rightMatcher.valueType, .Integer, "should be integer")
        XCTAssertEqual(matcher.rightMatcher.sign, .LessThan, "should be less than")
        XCTAssertEqual(matcher.rightMatcher.value, -10, "should be -10")
    }

}

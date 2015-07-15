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
    
    func createMatcher(pattern: ExpressionPattern) -> InequalityExtendedExpressionMatcher {
        return InequalityExtendedExpressionParser(pattern).parse() as! InequalityExtendedExpressionMatcher
    }
    
    func testMatcher1() {
        let m = createMatcher("iex:4<x<10")
        XCTAssertEqual(m.leftMatcher.sign, .GreaterThan, "")
        XCTAssertEqual(m.leftMatcher.value, 4, "")
        
        XCTAssertEqual(m.rightMatcher.sign, .LessThan, "")
        XCTAssertEqual(m.rightMatcher.value, 10, "")
    }
    
    func testMatcher2() {
        let m = createMatcher("iex:4<=x<=10")
        XCTAssertEqual(m.leftMatcher.sign, .GreaterThanOrEqual, "")
        XCTAssertEqual(m.leftMatcher.value, 4, "")
        
        XCTAssertEqual(m.rightMatcher.sign, .LessThanOrEqual, "")
        XCTAssertEqual(m.rightMatcher.value, 10, "")
    }
    
    func testMatcher3() {
        let m = createMatcher("iex:4<=x<=10")
        XCTAssertEqual(m.leftMatcher.sign, .GreaterThanOrEqual, "")
        XCTAssertEqual(m.leftMatcher.value, 4, "")
        
        XCTAssertEqual(m.rightMatcher.sign, .LessThanOrEqual, "")
        XCTAssertEqual(m.rightMatcher.value, 10, "")
    }
    
    func testMatcher4() {
        let m = createMatcher("iex:4<x<10")
        XCTAssertEqual(m.leftMatcher.sign, .GreaterThan, "")
        XCTAssertEqual(m.leftMatcher.value, 4, "")
        
        XCTAssertEqual(m.rightMatcher.sign, .LessThan, "")
        XCTAssertEqual(m.rightMatcher.value, 10, "")
    }
    
    func testMatcher5() {
        let m = createMatcher("iex:4<=x<10")
        XCTAssertEqual(m.leftMatcher.sign, .GreaterThanOrEqual, "")
        XCTAssertEqual(m.leftMatcher.value, 4, "")
        
        XCTAssertEqual(m.rightMatcher.sign, .LessThan, "")
        XCTAssertEqual(m.rightMatcher.value, 10, "")
    }
    
    func testMatcher6() {
        let m = createMatcher("iex:-4<=x<-10")
        XCTAssertEqual(m.leftMatcher.sign, .LessThanOrEqual, "")
        XCTAssertEqual(m.leftMatcher.value, -4, "")
        
        XCTAssertEqual(m.rightMatcher.sign, .LessThan, "")
        XCTAssertEqual(m.rightMatcher.value, -10, "")
    }

}

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

    func createMatcher(_ pattern: ExpressionPattern) -> InequalityExpressionMatcher {
        return InequalityExpressionParser(pattern).parse() as! InequalityExpressionMatcher
    }
    
    // MARK: - Int
    func testIE1() {
        let m = createMatcher("ie:x=3")
        XCTAssertEqual(m.sign, InequalitySign.Equal, "")
        XCTAssertEqual(m.value, 3, "")
    }
    
    func testIE2() {
        let m = createMatcher("ie:x>3")
        XCTAssertEqual(m.sign, InequalitySign.GreaterThan, "")
        XCTAssertEqual(m.value, 3, "")
    }
    
    func testIE3() {
        let m = createMatcher("ie:x<3")
        XCTAssertEqual(m.sign, InequalitySign.LessThan, "")
        XCTAssertEqual(m.value, 3, "")
    }
    
    func testIE4() {
        let m = createMatcher("ie:x<=3")
        XCTAssertEqual(m.sign, InequalitySign.LessThanOrEqual, "")
        XCTAssertEqual(m.value, 3, "")
    }
    
    func testIE5() {
        let m = createMatcher("ie:x>=3")
        XCTAssertEqual(m.sign, InequalitySign.GreaterThanOrEqual, "")
        XCTAssertEqual(m.value, 3, "")
    }
    
    func testIE6() {
        let m = createMatcher("ie:x=11")
        XCTAssertEqual(m.sign, InequalitySign.Equal, "")
        XCTAssertEqual(m.value, 11, "")
    }
    
    func testIE7() {
        let m = createMatcher("ie:x=-5")
        XCTAssertEqual(m.sign, InequalitySign.Equal, "")
        XCTAssertEqual(m.value, -5, "")
    }
    
    // MARK: - Float
    func testIE8() {
        let m = createMatcher("ie:x=3.0")
        XCTAssertEqual(m.sign, InequalitySign.Equal, "")
        XCTAssertEqual(m.value, 3.0, "")
    }
    
    func testIE9() {
        let m = createMatcher("ie:x<3.6")
        XCTAssertEqual(m.sign, InequalitySign.LessThan, "")
        XCTAssertEqual(m.value, 3.6, "")
    }
    
    func testIE10() {
        let m = createMatcher("ie:x>-44.45")
        XCTAssertEqual(m.sign, InequalitySign.GreaterThan, "")
        XCTAssertEqual(m.value, -44.45, "")
    }
    
    func testIE11() {
        let m = createMatcher("ie:x>=-44.45")
        XCTAssertEqual(m.sign, InequalitySign.GreaterThanOrEqual, "")
        XCTAssertEqual(m.value, -44.45, "")
    }
}

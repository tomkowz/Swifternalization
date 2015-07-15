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
    
    let steps: Int = 1_000
    
    func createMatcher(expression: ExpressionPattern) -> InequalityExpressionMatcher {
        return InequalityExpressionParser(expression).parse() as! InequalityExpressionMatcher
    }
    
    // MARK: Int
    func testIE1() {
        let m = createMatcher("ie:x=3")
        XCTAssertTrue(m.validate("3"), "")
        XCTAssertTrue(m.validate("3.0"), "")
        for n in Float.randomNumbersStrings(lower: -100.33, upper: 100.99, count: steps) { XCTAssertFalse(m.validate(n), "") }
    }
    
    func testIE2() {
        let m = createMatcher("ie:x<=3")
        for n in Float.randomNumbersStrings(lower: -9999, upper: 3.0, count: steps) { XCTAssertTrue(m.validate(n), "") }
        for n in Float.randomNumbersStrings(lower: 3.00001, upper: 1000000, count: steps) { XCTAssertFalse(m.validate(n), "") }
    }
    
    func testIE3() {
        let m = createMatcher("ie:x>=3")
        for n in Float.randomNumbersStrings(lower: 3.0, upper: 999999, count: steps) { XCTAssertTrue(m.validate(n), "") }
        for n in Float.randomNumbersStrings(lower: -999999, upper: 2.9999999, count: steps) { XCTAssertFalse(m.validate(n), "") }
    }
    
    func testIE4() {
        let m = createMatcher("ie:x>3")
        for n in Float.randomNumbersStrings(lower: 3.0001, upper: 999999, count: steps) { XCTAssertTrue(m.validate(n), "") }
        for n in Float.randomNumbersStrings(lower: -999999, upper: 3.000000, count: steps) { XCTAssertFalse(m.validate(n), "") }
    }
    
    func testIE5() {
        let m = createMatcher("ie:x<3")
        for n in Float.randomNumbersStrings(lower: -99999, upper: 2.9999, count: steps) { XCTAssertTrue(m.validate(n), "") }
        for n in Float.randomNumbersStrings(lower: 3.0000, upper: 999999, count: steps) { XCTAssertFalse(m.validate(n), "") }
    }
    
    // MARK: Float
    func testIE6() {
        let m = createMatcher("ie:x<=4.3")
        for n in Float.randomNumbersStrings(lower: -99999, upper: 4.3, count: steps) { XCTAssertTrue(m.validate(n), "") }
        for n in Float.randomNumbersStrings(lower: 4.31, upper: 10000000, count: steps) { XCTAssertFalse(m.validate(n), "") }
    }
    
    func testIE7() {
        let m = createMatcher("ie:x>-199")
        for n in Float.randomNumbersStrings(lower: -198, upper: 99999, count: steps) { XCTAssertTrue(m.validate(n), "") }
        for n in Float.randomNumbersStrings(lower: -99999, upper: -199, count: steps) { XCTAssertFalse(m.validate(n), "") }
    }
}

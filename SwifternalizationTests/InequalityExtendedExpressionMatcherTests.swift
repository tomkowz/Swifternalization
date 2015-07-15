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
    
    func createMatcher(pattern: ExpressionPattern) -> InequalityExtendedExpressionMatcher {
        return InequalityExtendedExpressionParser(pattern).parse() as! InequalityExtendedExpressionMatcher
    }
    
    // MARK: - Int
    func testIEX1() {
        let m = createMatcher("iex:4<x<6")
        XCTAssertTrue(m.validate("5"), "")
        XCTAssertFalse(m.validate("4"), "")
        XCTAssertFalse(m.validate("6"), "")
    }
    
    func testIEX2() {
        let m = createMatcher("iex:4<=x<10")
        XCTAssertTrue(m.validate("4"), "")
        XCTAssertFalse(m.validate("10"), "")
        XCTAssertFalse(m.validate("11"), "")
    }
    
    func testIEX3() {
        let m = createMatcher("iex:4=x=10")
        XCTAssertFalse(m.validate("4"), "")
        XCTAssertFalse(m.validate("10"), "")
        XCTAssertFalse(m.validate("8"), "")
    }
    
    // MARK: - Float
    func testIEX4() {
        let m = createMatcher("iex:4.99<x<9.99")
        XCTAssertTrue(m.validate("5.03"), "")
        XCTAssertFalse(m.validate("4.99"), "")
        XCTAssertFalse(m.validate("10"), "")
    }
    
    func testIEX5() {
        let m = createMatcher("iex:-10.33<=x<10.4")
        XCTAssertTrue(m.validate("0.16"), "")
        XCTAssertFalse(m.validate("-10.35"), "")
        XCTAssertFalse(m.validate("11"), "")
    }
    
    func testIEX6() {
        let m = createMatcher("iex:-13<=x<15")
        XCTAssertTrue(m.validate("0.16"), "")
        XCTAssertTrue(m.validate("-10.35"), "")
        XCTAssertTrue(m.validate("11"), "")
        XCTAssertFalse(m.validate("18"), "")
    }
    
    func testIEX7() {
        let m = createMatcher("iex:-10.5<=x<10")
        XCTAssertTrue(m.validate("-7"), "")
        XCTAssertFalse(m.validate("10"), "")
        XCTAssertFalse(m.validate("11"), "")
    }
    
    func testIEX8() {
        let m = createMatcher("iex:5.5<=x<=9.7")
        XCTAssertTrue(m.validate("5.5"), "")
        XCTAssertTrue(m.validate("9.7"), "")
        XCTAssertFalse(m.validate("-4.3"), "")
        XCTAssertFalse(m.validate("4.3"), "")
        XCTAssertFalse(m.validate("11"), "")
    }
    
    func testIEX9() {
        let m = createMatcher("iex:4.3<x<=9")
        XCTAssertTrue(m.validate("5.5"), "")
        XCTAssertFalse(m.validate("-4.3"), "")
        XCTAssertFalse(m.validate("4.3"), "")
        XCTAssertFalse(m.validate("11"), "")
    }
    
    func testIEX10() {
        let m = createMatcher("iex:-20<x<-10")
        XCTAssertTrue(m.validate("-19"), "")
        XCTAssertFalse(m.validate("-9"), "")
        XCTAssertFalse(m.validate("-21"), "")
        XCTAssertFalse(m.validate("4.3"), "")
        XCTAssertFalse(m.validate("7"), "")
    }
}

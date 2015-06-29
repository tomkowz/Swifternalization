//
//  SwifternalizationTests.swift
//  SwifternalizationTests
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest
import Swifternalization

class SwifternalizationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Swifternalization(bundle: NSBundle(forClass: self.dynamicType))
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShouldReturnKeyWhenNotTranslated() {
        XCTAssertEqual(Swifternalization.localizedString("not-found"), "not-found", "Should return key")
    }
    
    func testShouldReturnDefaultValueInsteadOfKeyWhenNotTranslated() {
        XCTAssertEqual(Swifternalization.localizedString("not-found", defaultValue: "something"), "something", "Should return alternative value")
    }
    
    // Primitive
    func testPrimitive1() {
        XCTAssertEqual(Swifternalization.localizedString("welcome-key"), "welcome", "")
    }
    
    // Inequality
    func testInequality1() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("cars", value: "1"), "one car", "")
    }

    func testInequality2() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("cars", value: "2"), "%d cars", "")
    }
    
    func testInequality3() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("cars", value: "-3"), "minus %d cars", "")
    }
    
    // Shared Expression
    func testSharedExpression1() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("things", value: 10), "10 things", "")
    }
    
    func testSharedExpression2() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("things", value: 26), ">20 things", "")
    }
    
    
    /// Polish
    
    // Inequality
    func testPLInequality1() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("pl-cars", value: "1"), "jeden samochód", "")
    }
    
    // Inequality Extended
    func testPLInequalityExtended2() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("pl-cars", value: "2"), "%d samochody", "")
    }
    
    func testPLInequalityExtended3() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("pl-cars", value: "-3"), "-2 - -4 samochody", "")
    }
    
    // Regex
    func testPLRegex1() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("pl-police-cars", value: "1"), "1 samochód policyjny", "")
    }
    
    func testPLRegex2() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("pl-police-cars", value: "2"), "%d samochody policyjne", "")
    }
    
    func testPLRegex3() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("pl-police-cars", value: "5"), "%d samochodów policyjnych", "")
    }
    
    func testPLRegex4() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("pl-police-cars", value: 13), "%d samochodów policyjnych", "")
    }
}


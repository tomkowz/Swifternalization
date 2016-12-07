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
        Swifternalization.configure(Bundle.testBundle())
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
        XCTAssertEqual(Swifternalization.localizedString("cars", intValue: 1), "one car", "")
    }

    func testInequality2() {
        XCTAssertEqual(Swifternalization.localizedString("cars", intValue: 2), "%d cars", "")
    }
    
    func testInequality3() {
        XCTAssertEqual(Swifternalization.localizedString("cars", intValue: -3), "minus %d cars", "")
    }
    
    // Shared Expression
    func testSharedExpression1() {
        XCTAssertEqual(Swifternalization.localizedString("things", intValue: 10), "10 things", "")
    }
    
    func testSharedExpression2() {
        XCTAssertEqual(Swifternalization.localizedString("things", intValue: 26), ">20 things", "")
    }
    
    func testValueWithFormat() {
        let format = Swifternalization.localizedString("put.?.here.format")
        XCTAssertEqual(String(format: format, arguments: ["word"]), "put word here")
    }

    
    /// Polish
    
    // Inequality
    func testPLInequality1() {
        XCTAssertEqual(Swifternalization.localizedString("pl-cars", intValue: 1), "jeden samochód", "")
    }
    
    // Inequality Extended
    func testPLInequalityExtended2() {
        XCTAssertEqual(Swifternalization.localizedString("pl-cars", intValue: 2), "%d samochody", "")
    }
    
    func testPLInequalityExtended3() {
        XCTAssertEqual(Swifternalization.localizedString("pl-cars", intValue: -3), "-2 - -4 samochody", "")
    }
    
    // Regex
    func testPLRegex1() {
        XCTAssertEqual(Swifternalization.localizedString("pl-police-cars", intValue: 1), "1 samochód policyjny", "")
    }
    
    func testPLRegex2() {
        XCTAssertEqual(Swifternalization.localizedString("pl-police-cars", intValue: 2), "%d samochody policyjne", "")
    }
    
    func testPLRegex3() {
        XCTAssertEqual(Swifternalization.localizedString("pl-police-cars", intValue: 5), "%d samochodów policyjnych", "")
    }
    
    func testPLRegex4() {
        XCTAssertEqual(Swifternalization.localizedString("pl-police-cars", intValue: 13), "%d samochodów policyjnych", "")
    }
}


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
        XCTAssertEqual(Swifternalization.localizedString("welcome-key"), "welcome", "Should equal 'welcome'")
    }
    
    // Inequality
    func testInequality1() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("en-cars", value: "1"), "one car", "should be equal 'one car'")
    }
    
    func testInequality2() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("en-cars", value: "2"), "%d cars", "should be equal 'one car'")
    }
    
    // Inequality Extended
    func testInequalityExtended1() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("pl-cars", value: "4"), "%d samochody", "")
    }
    
    // Regex
    func testRegex1() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("pl-police-cars", value: "1"), "1 samochód policyjny", "should be equal '1 samochód policyjny")
    }
    
    func testRegex2() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("pl-police-cars", value: "2"), "%d samochody policyjne", "should be equal '%d samochody policyjne")
    }
    
    func testRegex3() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("pl-police-cars", value: "5"), "%d samochodów policyjnych", "should be equal '%d samochodów policyjnych")
    }
}


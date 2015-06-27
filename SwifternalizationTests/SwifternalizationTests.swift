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
    
    func testTranslateSimpleKey() {
        XCTAssertEqual(Swifternalization.localizedString("welcome-key"), "welcome", "Should equal 'welcome'")
    }
    
    func testShouldReturnKeyWhenNotTranslated() {
        XCTAssertEqual(Swifternalization.localizedString("not-found"), "not-found", "Should return key")
    }
    
    func testShouldReturnDefaultValueInsteadOfKeyWhenNotTranslated() {
        XCTAssertEqual(Swifternalization.localizedString("not-found", defaultValue: "something"), "something", "Should return alternative value")
    }
    
    func testShouldReturnValueForEqualCase() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("cars-formatter", value: "1"), "one car", "should be equal 'one car'")
    }
    
    func testShouldReturnValueForGreaterThanOrEqualCase() {
        XCTAssertEqual(Swifternalization.localizedExpressionString("cars-formatter", value: "2"), "%d cars", "should be equal 'one car'")
        XCTAssertEqual(Swifternalization.localizedExpressionString("cars-formatter", value: "4"), "%d cars", "should be equal 'one car'")
    }
}

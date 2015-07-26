//
//  ExpressionsLoaderTests.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 21/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest

class SharedExpressionsLoaderTests: XCTestCase {
    
    func testShouldLoadBase() {
        let content = SharedExpressionsLoader.loadExpressions("base", bundle: NSBundle.testBundle())
        XCTAssertTrue(content.count > 0, "")
    }
    
    func testShouldLoadPL() {
        let content = SharedExpressionsLoader.loadExpressions("pl", bundle: NSBundle.testBundle())
        XCTAssertTrue(content.count > 0, "")
    }
    
    func testShouldNotLoadDE() {
        let content = SharedExpressionsLoader.loadExpressions("de", bundle: NSBundle.testBundle())
        XCTAssertFalse(content.count > 0, "")
    }
}

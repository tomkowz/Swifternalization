//
//  ExpressionsLoaderTests.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 21/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest

class ExpressionsLoaderTests: XCTestCase {
    
    func testShouldLoadBase() {
        let content = ExpressionsLoader.loadExpressions("base", bundle: NSBundle.testBundle())
        XCTAssertTrue(content.count > 0, "")
    }
    
    func testShouldLoadPL() {
        let content = ExpressionsLoader.loadExpressions("pl", bundle: NSBundle.testBundle())
        XCTAssertTrue(content.count > 0, "")
    }
    
    func testShouldNotLoadDE() {
        let content = ExpressionsLoader.loadExpressions("de", bundle: NSBundle.testBundle())
        XCTAssertFalse(content.count > 0, "")
    }
}

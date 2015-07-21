//
//  JSONFileLoaderTests.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 21/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest

class JSONFileLoaderTests: XCTestCase {

    func testJSONShouldBeLoaded() {
        let content = JSONFileLoader.load("base", bundle: NSBundle.testBundle())
        XCTAssertNotNil(content!, "")
    }
    
    func testFileShouldNotBeLoaded() {
        let content = JSONFileLoader.load("not-existing", bundle: NSBundle.testBundle())
        XCTAssertNil(content, "")
    }
}

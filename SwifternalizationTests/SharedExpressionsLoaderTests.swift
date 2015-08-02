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
    
    func testShouldLoadExpressions() {
        let expressions = SharedExpressionsLoader.loadExpressions(ExpressionJSONs.base())
        XCTAssertEqual(expressions.count, 3, "")
    }
}

//
//  ExpressionTests.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest
import Swifternalization

class ExpressionTests: XCTestCase {

    func testExpressionShouldBeCreated() {
        XCTAssertTrue(Expression.expressionFromString("abc{=2}") != nil, "Expression should be created")
    }
    
    func testExpressionCannotBeCreated() {
        XCTAssertTrue(Expression.expressionFromString("abc") == nil, "There is no expression here")
    }
}

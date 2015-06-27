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

    func testInequality() {
        XCTAssertTrue(Expression.expressionFromString("abc{ie:%d=2}") != nil, "Expression should be created")
    }
    
    func testInequalityExtended() {
        XCTAssertTrue(Expression.expressionFromString("abc{iex:4<%d<=5}") != nil, "Expression should be created")
    }
    
    func testRegex() {
        XCTAssertTrue(Expression.expressionFromString("abc{exp:.*}") != nil, "Expression should be created")
    }
    
    func testNone() {
        XCTAssertTrue(Expression.expressionFromString("abc") == nil, "There is no expression here")
    }
}

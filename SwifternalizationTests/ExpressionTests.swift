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

    func testThatInequalityExpressionShouldBeCreated() {
        XCTAssertTrue(Expression.expressionFromString("abc{ie:%d=2}") != nil, "Expression should be created")
    }
    
    func testThatInequalityExtendedExpressionShouldBeCreated() {
        XCTAssertTrue(Expression.expressionFromString("abc{iex:4<%d<=5}") != nil, "Expression should be created")
    }
    
    func testThatRegexExpressionShouldBeCreated() {
        XCTAssertTrue(Expression.expressionFromString("abc{exp:.*}") != nil, "Expression should be created")
    }
    
    func testThatExpressionCannotBeCreated() {
        XCTAssertTrue(Expression.expressionFromString("abc") == nil, "There is no expression here")
    }
    
    func testThatExpressionCannotBeFound() {
        XCTAssertFalse(Expression.parseExpressionPattern("{abc}") == nil, "Expression should not be found")
    }
    
    func testThatExpressionCanBeFound() {
        XCTAssertTrue(Expression.parseExpressionPattern("{ie:%d>2}") != nil, "Expression should be found")
    }
}

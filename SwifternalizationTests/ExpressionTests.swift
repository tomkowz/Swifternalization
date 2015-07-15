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
    // MARK: - IE
    func testIESupported1() {
        XCTAssertTrue(Expression.parseExpressionPattern("{ie:x>2}") != nil, "")
    }
    
    func testIESupported2() {
        XCTAssertNotNil(Expression.parseExpressionPattern("{ie:x>0.2}"), "")
    }
    
    func testIESupported3() {
        XCTAssertTrue(Expression.expressionFromString("abc{ie:x=2}") != nil, "")
    }
    
    // MARK: - IEX
    func testIEXSupported1() {
        XCTAssertNotNil(Expression.parseExpressionPattern("{iex:0.1<x<0.2}"), "")
    }
    
    func testIEXSupported2() {
        XCTAssertNotNil(Expression.parseExpressionPattern("{iex:-10.1<x<9999.7676762}"), "")
    }
    
    func testIEXSupported3() {
        XCTAssertTrue(Expression.expressionFromString("abc{iex:4<x<=5}") != nil, "")
    }
    
    // MARK: - EX
    func testEXPSupported1() {
        XCTAssertTrue(Expression.expressionFromString("abc{exp:.*}") != nil, "")
    }
    
    // MARK: - Not supported
    func testNotSupported1() {
        XCTAssertFalse(Expression.parseExpressionPattern("{abc}") == nil, "")
    }
    
    func testNotSupported2() {
        XCTAssertTrue(Expression.expressionFromString("abc") == nil, "")
    }
}

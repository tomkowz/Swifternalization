//
//  SharedPolishExpressionTests.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest

class SharedPolishExpressionTests: XCTestCase {

    func testFew() {
        let sharedExp = SharedPolishExpression.allExpressions().filter({$0.key == "few"}).first!
        let expression = Expression(pattern: sharedExp.expression)!
        
        XCTAssertTrue(expression.validate("2"), "Should match 2")
        XCTAssertTrue(expression.validate("24"), "Should match 24")
        XCTAssertTrue(expression.validate("153"), "Should match 153")
        XCTAssertTrue(expression.validate("454"), "Should match 454")
        XCTAssertTrue(expression.validate("1443"), "Should match 1443")
        XCTAssertTrue(expression.validate("3443"), "Should match 3443")

        XCTAssertFalse(expression.validate("12"), "Should not match 12")
        XCTAssertFalse(expression.validate("25"), "Should not match 25")
    }
    
    func testMany() {
        let sharedExp = SharedPolishExpression.allExpressions().filter({$0.key == "many"}).first!
        let expression = Expression(pattern: sharedExp.expression)!
        
        XCTAssertTrue(expression.validate("10"), "Should match 10")
        XCTAssertTrue(expression.validate("18"), "Should match 18")
        XCTAssertTrue(expression.validate("1009"), "Should match 1009")
        
        XCTAssertFalse(expression.validate("22"), "Should not match 22")
        XCTAssertFalse(expression.validate("24"), "Should not match 24")
        XCTAssertFalse(expression.validate("153"), "Should not match 153")
        XCTAssertFalse(expression.validate("454"), "Should not match 454")
        XCTAssertFalse(expression.validate("1443"), "Should not match 1443")
        XCTAssertFalse(expression.validate("3443"), "Should not match 3443")
    }
}

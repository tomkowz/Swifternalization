//
//  SharedRussianExpressionTests.swift
//  Swifternalization
//
//  Created by Anton Domashnev on 8/24/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest

class SharedRussianExpressionTests: XCTestCase {
    
    func testOne() {
        let sharedExp = SharedRussianExpression.allExpressions().filter({$0.identifier == "one"}).first!
        let expression = Expression(pattern: sharedExp.pattern, value: "")
        
        XCTAssertTrue(expression.validate("1"), "Should match 1")
        XCTAssertTrue(expression.validate("21"), "Should match 21")
        XCTAssertTrue(expression.validate("101"), "Should match 151")
        XCTAssertTrue(expression.validate("451"), "Should match 451")
        XCTAssertTrue(expression.validate("1441"), "Should match 1441")
        XCTAssertTrue(expression.validate("3441"), "Should match 3441")
        
        XCTAssertFalse(expression.validate("11"), "Should not match 11")
        XCTAssertFalse(expression.validate("25"), "Should not match 25")
        XCTAssertFalse(expression.validate("111"), "Should not match 111")
        XCTAssertFalse(expression.validate("1211"), "Should not match 1211")
    }
    
    func testFew() {
        let sharedExp = SharedRussianExpression.allExpressions().filter({$0.identifier == "few"}).first!
        let expression = Expression(pattern: sharedExp.pattern, value: "")
        
        XCTAssertTrue(expression.validate("2"), "Should match 2")
        XCTAssertTrue(expression.validate("23"), "Should match 23")
        XCTAssertTrue(expression.validate("564"), "Should match 564")
        XCTAssertTrue(expression.validate("1873"), "Should match 1873")
        
        XCTAssertFalse(expression.validate("5"), "Should not match 5")
        XCTAssertFalse(expression.validate("12"), "Should not match 12")
        XCTAssertFalse(expression.validate("18"), "Should not match 18")
        XCTAssertFalse(expression.validate("39"), "Should not match 39")
        XCTAssertFalse(expression.validate("1413"), "Should not match 1413")
        XCTAssertFalse(expression.validate("41511"), "Should not match 41511")
    }
    
    func testMany() {
        let sharedExp = SharedRussianExpression.allExpressions().filter({$0.identifier == "many"}).first!
        let expression = Expression(pattern: sharedExp.pattern, value: "")
        
        XCTAssertTrue(expression.validate("0"), "Should match 0")
        XCTAssertTrue(expression.validate("6"), "Should match 6")
        XCTAssertTrue(expression.validate("10"), "Should match 10")
        XCTAssertTrue(expression.validate("18"), "Should match 18")
        XCTAssertTrue(expression.validate("1009"), "Should match 1009")
        XCTAssertTrue(expression.validate("2011"), "Should match 2011")
        XCTAssertTrue(expression.validate("8314"), "Should match 8314")
        
        XCTAssertFalse(expression.validate("22"), "Should not match 22")
        XCTAssertFalse(expression.validate("24"), "Should not match 24")
        XCTAssertFalse(expression.validate("153"), "Should not match 153")
        XCTAssertFalse(expression.validate("454"), "Should not match 454")
        XCTAssertFalse(expression.validate("1443"), "Should not match 1443")
        XCTAssertFalse(expression.validate("3443"), "Should not match 3443")
    }
}

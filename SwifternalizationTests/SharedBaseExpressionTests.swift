//
//  SharedBaseExpressionTests.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest
import Swifternalization

class SharedBaseExpressionTests: XCTestCase {

    func testOne() {
        let sharedExp = SharedBaseExpression.allExpressions().filter({$0.identifier == "one"}).first!
        let expression = Expression(pattern: sharedExp.pattern, value: "")
        
        XCTAssertTrue(expression.validate("1"), "Should match 1")
        XCTAssertFalse(expression.validate("2"), "Should not match 2")
    }
    
    func testMoreThanOne() {
        let sharedExp = SharedBaseExpression.allExpressions().filter({$0.identifier == ">one"}).first!
        let expression = Expression(pattern: sharedExp.pattern, value: "")
        
        XCTAssertTrue(expression.validate("2"), "Should match 2")
        XCTAssertTrue(expression.validate("3"), "Should match 3")
        XCTAssertFalse(expression.validate("1"), "Should not match 1")
    }
    
    func testTwo() {
        let sharedExp = SharedBaseExpression.allExpressions().filter({$0.identifier == "two"}).first!
        let expression = Expression(pattern: sharedExp.pattern, value: "")
        
        XCTAssertTrue(expression.validate("2"), "Should match 2")
        XCTAssertFalse(expression.validate("1"), "Should not match 1")
    }
    
    func testOther() {
        let sharedExp = SharedBaseExpression.allExpressions().filter({$0.identifier == "other"}).first!
        let expression = Expression(pattern: sharedExp.pattern, value: "")
        
        XCTAssertTrue(expression.validate("0"), "Should match 0")
        XCTAssertTrue(expression.validate("2"), "Should match 2")
        XCTAssertTrue(expression.validate("3"), "Should match 3")
        XCTAssertFalse(expression.validate("1"), "Should not match 1")
    }
    
    func testIssue21() {
        let bundle = Bundle(for: SharedBaseExpressionTests.self)
        Swifternalization.configure(bundle)
        let strOne = I18n.localizedString("issue21", intValue: 1)
        let strOther = I18n.localizedString("issue21", intValue: 15)
        
        XCTAssertEqual(strOne, "1 follow request")
        XCTAssertEqual(String(format: strOther, 15), "15 follow requests")
    }
}

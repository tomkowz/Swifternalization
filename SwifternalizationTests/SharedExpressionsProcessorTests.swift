//
//  SharedExpressionsProcessor.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 26/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation
import XCTest

class SharedExpressionsProcessorTests: XCTestCase {
    
    func testShouldProcessExpressions() {
        let base = SharedExpressionsLoader.loadExpressions(ExpressionJSONs.base())
        let en = SharedExpressionsLoader.loadExpressions(ExpressionJSONs.en())
        
        let shared = SharedExpressionsProcessor.processSharedExpression("en", preferedLanguageExpressions: base, baseLanguageExpressions: en)
        XCTAssertEqual(shared.count, 9, "")
    }
}

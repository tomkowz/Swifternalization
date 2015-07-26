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

    func testThatAllExpressionsShouldBeLoadedCorreclty() {
        let baseExpressions = SharedExpressionsLoader.loadExpressions("base", bundle: NSBundle.testBundle())
        let preferedExpressions = SharedExpressionsLoader.loadExpressions("pl", bundle: NSBundle.testBundle())

        let sharedExpressions = SharedExpressionsProcessor.processSharedExpression("pl", preferedLanguageExpressions: preferedExpressions, baseLanguageExpressions: baseExpressions)
        
        XCTAssertEqual(sharedExpressions.count, 8, "")
    }
}

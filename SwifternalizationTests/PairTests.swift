//
//  PairTests.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest
import Swifternalization

class PairTests: XCTestCase {
    
    func testShouldNotHaveExpression() {
        XCTAssertFalse(Pair(key: "abc", value: "def").hasExpression, "Shouldn't have expression")
    }
    
    func testShouldHaveExpression() {
        XCTAssertTrue(Pair(key: "abc{=2}", value: "def").hasExpression, "Should have expression")
    }
}

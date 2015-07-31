//
//  JSONFileLoaderTests.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 21/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest

class JSONFileLoaderTests: XCTestCase {
    
    // Expressions
    func loadExpressions(cc: CountryCode) -> Dictionary<String, String>? {
        return JSONFileLoader.loadExpressions(cc, bundle: NSBundle.testBundle())
    }
    
    func testShouldLoadBaseExpressions() {
        XCTAssertNotNil(loadExpressions("base"), "")
    }
    
    func testShouldLoadPLExpressions() {
        XCTAssertNotNil(loadExpressions("pl"), "")
    }
    
    func testShouldNotLoadDEExpressions() {
        XCTAssertNil(loadExpressions("de"), "")
    }
    
    // Translations
    func loadTranslations(cc: CountryCode) -> JSONDictionary? {
        return JSONFileLoader.loadTranslations(cc, bundle: NSBundle.testBundle())
    }

    func testShouldLoadBaseTranslations() {
        XCTAssertNotNil(loadTranslations("base"), "")
    }
    
    func testShouldLoadPLTranslations() {
        XCTAssertNotNil(loadTranslations("pl"), "")
    }
    
    func testShouldNotLoadDETranslations() {
        XCTAssertNil(loadTranslations("de"), "")
    }
}

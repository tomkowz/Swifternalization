//
//  TranslationsLoaderTests.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 26/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest

class TranslationsLoaderTests: XCTestCase {

    func testShouldLoadBase() {
        let content = TranslationsLoader.loadTranslations("pl", bundle: NSBundle.testBundle())
        XCTAssertTrue(content.count > 0, "")
    }
    
    func testShouldLoadPL() {
        let content = TranslationsLoader.loadTranslations("base", bundle: NSBundle.testBundle())
        XCTAssertTrue(content.count > 0, "")
    }
    
    func testShouldNotLoadDE() {
        let content = TranslationsLoader.loadTranslations("de", bundle: NSBundle.testBundle())
        XCTAssertFalse(content.count > 0, "")
    }
}

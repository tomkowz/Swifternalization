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

    func testShouldLoadTranslations() {
        let translations = TranslationsLoader.loadTranslations(TranslationJSONs.base())
        XCTAssertEqual(translations.count, 3, "")
    }
}

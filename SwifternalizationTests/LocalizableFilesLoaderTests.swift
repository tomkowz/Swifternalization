//
//  LocalizableFilesLoaderTests.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest
import Swifternalization

class LocalizableFilesLoaderTests: XCTestCase {

    var loader: LocalizableFilesLoader!
    var language: Language!
    
    override func setUp() {
        super.setUp()
        var bundle = NSBundle(forClass: self.dynamicType)
        language = bundle.preferredLocalizations.first as! String
        loader = LocalizableFilesLoader(bundle)
    }
    
    func testLoading1() {
        let result = loader.loadContentFromFilesOfType(.Localizable, language: language)
        XCTAssertTrue(result.base.count > 0, "Keys should be greater than 0")
        XCTAssertTrue(result.pref.count == 0, "There should be no preferred language dictionary")
    }
    
    func testLoading2() {
        let result = loader.loadContentFromFilesOfType(.Expressions, language: language)
        XCTAssertTrue(result.base.count > 0, "Keys should be greater than 0")
        XCTAssertTrue(result.pref.count == 0, "There should be no preferred language dictionary")
    }
}

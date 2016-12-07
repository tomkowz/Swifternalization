//
//  NSBundle+TestExtension.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 21/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

extension Bundle {
    class func testBundle() -> Bundle {
        return Bundle(for: JSONFileLoaderTests.self)
    }
}

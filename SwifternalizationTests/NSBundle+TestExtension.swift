//
//  NSBundle+TestExtension.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 21/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

extension NSBundle {
    class func testBundle() -> NSBundle {
        return NSBundle(forClass: JSONFileLoaderTests.self)
    }
}
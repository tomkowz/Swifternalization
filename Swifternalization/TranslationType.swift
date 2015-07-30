//
//  TranslationType.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 30/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Represents translation.
*/
protocol TranslationType {
    /// Key that identifies translation.
    var key: String {get}
}
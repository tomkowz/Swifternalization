//
//  SimpleTranslation.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 30/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/** 
Represents simple key-value translation.
*/
struct SimpleTranslation: TranslationType {
    /// Key that identifies a translation.
    let key: String
    
    /// Localized string.
    let value: String
}

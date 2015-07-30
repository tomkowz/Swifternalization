//
//  LoadedTranslation.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 30/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Struct that represents loaded translation.
*/
struct LoadedTranslation {
    /// A type of translation.
    let type: LoadedTranslationType
    
    /// A content of translation just loaded from a file.
    let content: Dictionary<String, AnyObject>
    
    /// Key that identifies this translation
    var key: String {
        return content.keys.first!
    }
}

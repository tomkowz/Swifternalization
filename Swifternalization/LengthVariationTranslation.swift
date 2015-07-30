//
//  LengthVariationTranslation.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 30/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Represents length variation translation.
*/
struct LengthVariationTranslation: TranslationType {
    /// Key that identifies a translation.
    let key: String
    
    /// Length variations.
    let variations: [LengthVariation]
}

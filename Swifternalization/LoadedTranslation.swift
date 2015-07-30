//
//  LoadedTranslation.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 30/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Specifies few types of available translation type.
*/
enum LoadedTranslationType {
    /** 
    Simple key-value pair.
    
        "welcome": "welcome"
    */
    case Simple
    
    /** 
    Pair where value is a dictionary with expressions.
    
        "cars": {
            "one": "1 car",
            "ie:x=2": "2 cars",
            "more": "%d cars"
        }
    */
    case WithExpressions
    
    /**
    Pair where value is a dictionary with length variations.
    
        "forgot-password": {
            "@100": "Forgot Password? Help.",
            "@200": "Forgot Password? Get password Help.",
            "@300": "Forgotten Your Password? Get password Help."
        }
    */
    case WithLengthVariations
    
    /**
    Pair where value is dictionary that contains dictionary with expression and 
    length variations.
    
        "car-sentence": {
            "one": {
                "@100": "one car",
                "@200": "just one car",
                "@300": "you've got just one car"
            },
            
            "more": {
                "@100": "%d cars",
                "@300": "you've got %d cars"
            }
        }
    */
    case WithExpressionsAndLengthVariations
    
    /// Not supported type.
    case NotSupported
}

/**
Struct that represents loaded translation.
*/
struct LoadedTranslation {
    /// A type of translation.
    let type: LoadedTranslationType
    
    /// A content of translation just loaded from a file.
    let content: Dictionary<String, AnyObject>
}

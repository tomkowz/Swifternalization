//
//  TranslationJSONs.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 31/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

class TranslationJSONs {
    
    class func base() -> [String : Any] {
        return [
            "key-1": "value-1",
            "key-2": [
                "@100": "value-2-1",
                "@200": "value-2-2",
                "@300": "value-2-3"
            ],
            "key-3": [
                "key-3-1": [
                    "@100": "value-3-1-1",
                    "@200": "value-3-1-2"
                ],
                
                "key-3-2": [
                    "@100": "value-3-2-1",
                    "@200": "value-3-2-2"
                ]
            ]
        ]
    }
    
    class func en() -> [String : Any] {
        return [
            "key-1": "en-value-1",
            "key-2": [
                "@100": "en-value-2-1",
                "@200": "en-value-2-2",
                "@300": "en-value-2-3"
            ],
            "key-4": [
                "key-4-1": [
                    "@100": "value-4-1-1",
                    "@200": "value-$-1-2"
                ],
                
                "key-4-2": [
                    "@100": "value-4-2-1",
                    "@200": "value-4-2-2"
                ]
            ]
        ]
    }
}

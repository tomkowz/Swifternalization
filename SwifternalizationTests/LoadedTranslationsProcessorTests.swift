//
//  LoadedTranslationsProcessorTests.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 31/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit
import XCTest

class LoadedTranslationsProcessorTests: XCTestCase {
    
    private func _baseExpressions() -> Dictionary<String, String> {
        return [
            "e1": "ie:x=1",
            "e2": "ie:x=2"
        ]
    }
    
    private func _enExpressions() -> Dictionary<String, String> {
        return [
            "e1": "ie:x=1",
            "e2": "ie:x=2",
            "e3": "ie:x=3",
            "e4": "ie:x=4"
        ]
    }
    
    private func _baseTranslations() -> Dictionary<String, AnyObject> {
        return [
            "k1": "v1",
            "k2": "v2",
            "k3": "v3",
            "k4": "v4"
        ]
    }
    
    private func _enTranslations() -> Dictionary<String, AnyObject> {
        return [
            "k1": "v1",
            "k2": [
                "@100": "v2-1",
                "@200": "v2-2"
            ],
            "k3": [
                "e1": "v3-1",
                "e2": "v3-2"
            ],
            "k4": [
                "e3": [
                    "@100": "v4-1",
                    "@200": "v4-2"
                ],
                
                "e4": [
                    "@100": "v4-3",
                    "@300": "v4-4"
                ],
                
                "e2": "v4-5"
            ]
        ]
    }
    
    func testShouldProcessTranslations() {
        let baseExpressions = SharedExpressionsLoader.loadExpressions(_baseExpressions())
        let enExpressions = SharedExpressionsLoader.loadExpressions(_enExpressions())
        let expressions = SharedExpressionsProcessor.processSharedExpression("en", preferedLanguageExpressions: enExpressions, baseLanguageExpressions: baseExpressions)
        
        let baseTranslations = TranslationsLoader.loadTranslations(_baseTranslations())
        let enTranslations = TranslationsLoader.loadTranslations(_enTranslations())
        var translations = LoadedTranslationsProcessor.processTranslations(baseTranslations, preferedLanguageTranslations: enTranslations, sharedExpressions: expressions)
        
        translations.sort(isOrderedBefore: {$0.key < $1.key})
        
        XCTAssertEqual(translations.count, 4, "")
        
        /** 
        Check if there is k1 translation
        */
        XCTAssertEqual(translations[0].key, "k1", "")

        /** 
        Check content of k2 translation
        */
        let k2Translation = translations[1]
        XCTAssertEqual(k2Translation.key, "k2", "")
        XCTAssertEqual(k2Translation.expressions.count, 1, "")
        let k2Expression = k2Translation.expressions[0]
        XCTAssertEqual(k2Expression.lengthVariations.count, 2, "")
        
        /** 
        Check content of k3 translation
        */
        let k3Translation = translations[2]
        XCTAssertEqual(k3Translation.key, "k3", "")
        XCTAssertEqual(k3Translation.expressions.count, 2, "")
        
        // Get patterns of expressions
        var k3ExpressionPatterns: [String] = k3Translation.expressions.map({ $0.pattern })
        k3ExpressionPatterns.sort(isOrderedBefore: {$0 < $1})
        
        var k3ExpressionsToMatch: [String] = [_enExpressions()["e1"]!, _enExpressions()["e2"]!]
        k3ExpressionsToMatch.sort(isOrderedBefore: {$0 < $1})
        
        XCTAssertEqual(k3ExpressionPatterns, k3ExpressionsToMatch, "")
        
        /**
        Check content of k4 translation
        */
        let k4Translation = translations[3]
        XCTAssertEqual(k4Translation.key, "k4", "")
        XCTAssertEqual(k4Translation.expressions.count, 3, "")
        
        // Get patterns of expressions
        var k4ExpressionPatterns: [String] = k4Translation.expressions.map({ $0.pattern })
        k4ExpressionPatterns.sort(isOrderedBefore: {$0 < $1})
        
        var k4ExpressionsToMatch: [String] = [_enExpressions()["e2"]!, _enExpressions()["e3"]!, _enExpressions()["e4"]!]
        k4ExpressionsToMatch.sort(isOrderedBefore: {$0 < $1})
        
        XCTAssertEqual(k4ExpressionPatterns, k4ExpressionsToMatch, "")
    }
}

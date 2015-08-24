//
//  SharedRussianExpression.swift
//  Swifternalization
//
//  Created by Anton Domashnev on 8/24/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

/**
Contains Russian expressions.
*/
class SharedRussianExpression: SharedExpressionProtocol {
    
    /**
    Return expressions that are valid in Poland.
    */
    static func allExpressions() -> [SharedExpression] {
        return [
            /**
            1, 21, 31, 41, 51, 61, 71, 81, 101, 1001, …
            
            e.g.
            - из 1 книги за 1 день
            */
            SharedExpression(identifier: "one", pattern: "exp:(^1$)|(^[^1]1$)|(^[1-9][0-9]?[0,2,3,4,5,6,7,8,9]+1$)"),
            
            /**
            (2-4), (22-24), (32-4), ..., (..>22, ..>23, ..>24)
            
            e.g.
            - 22 samochody, 1334 samochody, 53 samochody
            - 2 minuty, 4 minuty, 23 minuty
            */
            SharedExpression(identifier: "few", pattern: "exp:(((?!1).[2-4]{1})$)|(^[2-4]$)"),
            
            /**
            0, (5-9), (10-21), (25-31), ..., (..0, ..1, ..5-9)
            
            e.g.
            - 0 samochodów, 10 samochodów, 26 samochodów, 1147 samochodów
            - 5 minut, 18 minut, 117 minut, 1009 minut
            */
            SharedExpression(identifier: "many", pattern: "exp:(^[05-9]$)|(.*(?=1).[0-9]$)|(^[0-9]{1}.*[0156789]$)"),
        ]
    }
}

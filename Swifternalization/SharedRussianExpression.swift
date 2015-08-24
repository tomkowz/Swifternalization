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
            
            v = 0 and
            i % 10 = 1 and
            i % 100 != 11
            
            e.g.
            - из 1 книги за 1 день
            */
            SharedExpression(identifier: "one", pattern: "exp:(^1$)|(^[^1]1$)|(^[1-9][0-9]?[0,2,3,4,5,6,7,8,9]+1$)"),
            
            /**
            2~4, 22~24, 32~34, 42~44, 52~54, 62, 102, 1002, …
            
            v = 0 and
            i % 10 = 2..4 and
            i % 100 != 12..14
            
            e.g.
            - из 2 книг за 2 дня
            */
            SharedExpression(identifier: "few", pattern: "exp:(^[2-4]$)|(^[2-9][2-4]$)|([1-9]+[0-9]*[^1][2-4]$)"),
            
            /**
            0, 5~20, 100, 1000, 10000, 100000, 1000000, …
            
            v = 0 and
            i % 10 = 0 or
            v = 0 and
            i % 10 = 5..9 or
            v = 0 and
            i % 100 = 11..14
            
            e.g.
            - из 5 книг за 5 дней
            */
            SharedExpression(identifier: "many", pattern: "exp:(^[05-9]$)|(^1[1-4]$)|(^[1-9]+[0-9]*[5-9]$)|(^[1-9]+[0-9]*1{1}[1-4]$)|([1-9]+[0-9]*0$)"),
        ]
    }
}

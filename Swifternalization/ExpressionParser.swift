//
//  ExpressionParser.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

protocol ExpressionParser {
    var pattern: ExpressionPattern {get}

    func parse() -> ExpressionMatcher?
    init(_ pattern: ExpressionPattern)
}
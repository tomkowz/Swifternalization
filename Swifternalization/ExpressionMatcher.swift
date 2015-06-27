//
//  ExpressionMatcher.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

protocol ExpressionMatcher: Printable {
    func validate(val: String) -> Bool
}
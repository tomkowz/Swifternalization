//
//  InternalPatterns.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

enum InternalPatterns: String {
    case Expression = "(?<=\\{)(.+)(?=\\})"
    case ExpressionType = "(^.{2,3})(?=:)"
    case KeyWithoutExpression = "^(.*?)(?=\\{)"
}
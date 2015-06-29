//
//  InternalPatterns.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 28/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

/**
Represents internal patterns used by the framework to avoid copy-pastes.
*/
enum InternalPattern: String {
    /// Pattern that matches expressions.
    case Expression = "(?<=\\{)(.+)(?=\\})"
    
    /// Pattern that matches expression types.
    case ExpressionType = "(^.{2,3})(?=:)"
    
    /// Pattern that matches key without expression.
    case KeyWithoutExpression = "^(.*?)(?=\\{)"
}
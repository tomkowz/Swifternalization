//: Playground - noun: a place where people can play

import UIKit

let expsBase = ExpressionsLoader.loadExpressions("base")
let expsPL = ExpressionsLoader.loadExpressions("pl")
let translations = TranslationsLoader.loadTranslations("base")

for translation in translations {
    println(translation.key)
}
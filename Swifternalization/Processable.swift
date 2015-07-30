import Foundation

/** 
Specifies objects that need processing and are not final objects that can be 
used in the framework. An example of such object might be `ProcessableExpression` 
that is not ready to be used because it has to be converted into normal kind of 
expression that has its fields correctly filled.

Another good example is `TranslationTypeOld` object that contains expression or few 
that need to be processed.
*/
protocol Processable {}
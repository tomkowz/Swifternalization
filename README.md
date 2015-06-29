![Swifternalization: localize apps smarter](https://raw.githubusercontent.com/tomkowz/Swifternalization/master/page-assets/swifternalization-header.png)

[![Build Status](https://travis-ci.org/tomkowz/Swifternalization.svg?branch=master)](https://travis-ci.org/tomkowz/Swifternalization) 
![CocoaPods Status](https://img.shields.io/cocoapods/v/Swifternalization.svg)
<a href="https://flattr.com/submit/auto?user_id=tomkowz&url=http%3A%2F%2Fgithub.com%2Ftomkowz%2FSwifternalization" target="_blank"><img src="http://api.flattr.com/button/flattr-badge-large.png" alt="Flattr this" title="Flattr this" border="0"></a>

Swifternalization is library that helps in localizing apps. It is written in Swift.

# Features
- [x] Pluralization support - Avoids using .stringdicts
- [x] Expressions - inequality and regular expressions in Localizable.strings
- [x] Shared expressions
- [x] Built-in expressions
- [x] Works similarly to NSLocalizedString() macro
- [x] Uses Localizable.strings file as NSLocalizedString() macro does
- [x] Comprehensive Unit Test Coverage

# Swifternalization 
Swifternalization helps in localizing apps in a smarter way. It has been created because of necessary to solve Polish language internalization problems but it is universal and works with every language. 

## Failing builds (temporary section)
I noticed that Travis CI sometimes reports that build failed. I don't know why, it can pass and fail on the same commit so this is very weird. Framework is of course working and it is covered by many unit tests. I think this is some issue with wrong Travis configuration. [#4 Failing Travis CI builds](https://github.com/tomkowz/Swifternalization/issues/4)

## Installation
With CocoaPods:

    pod 'Swifternalization', '~> 1.0.2'

Without CocoaPods:
If you want to integrate it with your project just import files from *Swifternalization/Swifternalization* directory.

## Documentation
Documentation is in phase of writing... ;) You can find documentation in the latest state on [documentation branch](https://github.com/tomkowz/Swifternalization/tree/documentation/docs). It will be released in 2/3 days. - July 2nd. [#3 Create documentation for the framework](https://github.com/tomkowz/Swifternalization/issues/3)

## Real Example

Let's take a look on practical usage of Swifternalization. App supports both English and Polish languages. Naturally app contains two *Localizable.strings* files - one is Base for English (or English for English) and one is Polish... for Polish, obviously :)


App displays label with information that says when objects from the backend has been updated for the last time, e.g. "2 minutes ago".

This shouldn't be problem in English:

- 0, 2... second ago
- 1 second ago
- ...

The same with minutes and hours. This is easy. Localization file for English will looks like this one:

	Localizable.strings (Base)
	--------------------------
	
    "one-second" = "1 second ago";
    "many-seconds" = "%d seconds ago";
    
    "one-minute" = "1 minute ago";    
    "many-minutes" = "%d minutes ago";

	"one-hour" = "1 hour ago";
	"many-hours" = "%d hours ago";
	
	
Let's try with Polish language. As mentioned - this is tricky.

    Localizable.strings (Polish)
    ----------------------------
    
    "one-second" = "1 sekundę temu";
    "few-seconds" = "%d sekundy temu";
    "many-seconds" = "%d sekund temu";
    
    "one-minute" = "1 minutę temu";
    "few-minutes" = "%d minuty temu";
    "many-minutes" = "%d minut temu";
    
    "one-hours" = "1 hodzinę temu";
    "few-hours" = "%d godziny temu";
    "many-hours" = "%d godzin temu";
    
  
  
Okay... there is 9 cases for now. But this is not the only thing to deal with. It depends on the number of seconds/minutes/hours to select proper one. Without some logic additional logic to find out which case should be used this is impossible to use proper one.

    - 0, (5 - 21) - "few-seconds"
    - 1 - "one-second"
    - (2 - 4), (22-24), (32-34), (42, 44), ..., (162-164), ... - "many-seconds"
    
The same logic for minutes and hours. 


Here is nice table with [Language Plural Rules](http://www.unicode.org/cldr/charts/latest/supplemental/language_plural_rules.html) which covers cardinal forms of numbers in many languages - Many language handle plurality in their own way.


With Swifternalization this can be solved e.g. in this way:


	Localizable.strings (Base)
	--------------------------
	"time-seconds{one}" = "%d second ago";
	"time-seconds{other}" = "%d seconds ago";
	
	"time-minutes{one}" = "%d minute ago";
	"time-minutes{other}" = "%d minutes ago";

	"time-hours{one}" = "%d hour ago";
	"time-hours{other}" = "%d hours ago";
	
	
	
	Localizable.strings (Polish)
	----------------------------
	"time-seconds{one}" = "%d sekundę temu";
	"time-seconds{few}" = "%d sekundy temu";
	"time-seconds{many}" = "%d sekund temu";
	
	"time-minutes{one}" = "%d minutę temu";
	"time-minutes{few}" = "%d minuty temu";
	"time-minutes{many}" = "%d minut temu";
	
	"time-hours{one}" = "%d godzinę temu";
	"time-hours{few}" = "%d godziny temu";
	"time-hours{many}" = "%d godzin temu";

So the logic is in Swifternalization and you don't need write additional handling code for these cases.


And the call will look like this:

	Swifternalization.localizedExpressionString("time-seconds", value: 10)

or with `I18n` *typealias* (*I-18-letters-n, Internalization*):

	I18n.localizedExpressionString("time-seconds", value: 10)


There is easy way to add you own expression to handle your specific case with Swifternalization.

Swifternalization also drops need for having *.stringdicts* files like this one:

	<plist version="1.0">
	    <dict>
	        <key>%d file(s) remaining</key>
	        <dict>
	            <key>NSStringLocalizedFormatKey</key>
	            <string>%#@files@</string>
	            <key>files</key>
	            <dict>
	                <key>NSStringFormatSpecTypeKey</key>
	                <string>NSStringPluralRuleType</string>
	                <key>NSStringFormatValueTypeKey</key>
	                <string>d</string>
	                <key>one</key>
	                <string>%d file remaining</string>
	                <key>other</key>
	                <string>%d files remaining</string>
	            </dict>
	        </dict>
	    </dict>
	</plist>


## Getting Started

Configuration is simple. The one thing that Swifternalization needs to works is `NSBundle` where `Localizable.strings` are placed.

Recommended is to configure it as fast as you can to be sure that before you want to get some localized key it will be able to return you something.

        Swifternalization(bundle: NSBundle.mainBundle())
        
This call will create instance (you can get handle to it but you don't need it) and automatically set it as shared instance and you can easily work with it.

In *Localizable.strings* the syntax should looks like this:

	"key" = "value";
	"key{expression}" = "value";

### How to get localized string

Swifternalization allows developer to work with its class methods. There are few to use:

	localizedString(key: String, defaultValue: String? = nil) -> String

Allows to get value for simple key. Works similar to `NSLocalizedString`. `key` is the key placed in `Localizable.strings` and `defaultValue` is the value that will be returned when there is no translation found for passed key. If `defaultValue` is nil then key will be return in such case.

The next one is for getting localized string with keys that contain some expressions:
    
    localizedExpressionString(key: String, value: String, defaultValue: String? = nil) -> String
    
Similarly to the one above `key` is the key in `Localizable.strings`, `defaultValue` is also the same and methods behaves the same. There is additional parameter called `value`. The value is used for expression matchers to validate expressions and return proper localized value. We'll cover it soon.

As the method takes some `String` as a `value` and you probably will deal with `Int` there is alternative method to call:

	localizedExpressionString(key: String, value: Int, defaultValue: String? = nil) -> String



## Expressions

As mentioned there are few *expression types*. Every expression type has their own *parser* and *matcher*.

There are 3 types:

- *inequality* - this type of expression handles simple ineuqalities like: *%d<3*, *%d>10*, *%d=5*, *%d<=3*, and so on.
- *inequality extended* - this is extended version of *inequality* with syntax like this: *2<%d<10*, *4<=%d<6*.
- *regex* - this types of expression uses regular expression. This is the most powerful ;)


### Inequality
It supports numbers for now (probably there will be only supports for numbers)). It is composed of several elements:

- *ie:* - prefix of *inequality* expression
- *%d* - you have to always pass it, this means that *Int* will be used for this expression
- *<, <=, =, >=, >* - use one of inequality signs
- *1, 3, 5, 6, ...* - value to match is the last one in this expression

Example:

	"cars{ie:%d=1}" = "1 car";
	"cars{ie:%d=0}" = "no cars";
	"cars{ie:%d>1}" = "%d cars";
	

### Inequality Extended

This is a bit extended version of *inequality* expression. It is composed of 2 values, one value "marker" and two inequality signs.

- *iex:* - prefix of *inequality extended* expression
- *%d* - it also works only with *Int*s for now so just pass *%d* in the place of the value to be matched
- Inequality signs and possible values are the same like with *inequality* expression

Expample:

	"tomatos{iex:2<%d<10}" = "%d tomatos is between 2 and 10";



### Regex

This is the most powerful type of expression and probably will be most used by developers. It takes regular expression ;)

- *exp:* - prefix of *regex* expression
- *string* - it takes string with regular expression

Example: (police cars in Polish language)

	"police-cars{exp:^1$}" = "1 samochód policyjny";
	"police-cars{exp:(((?!1).[2-4]{1})$)|(^[2-4]$)}" = "%d samochody policyjne";
	"police-cars{exp:(.*(?=1).[0-9]$)|(^[05-9]$)|(.*(?!1).[0156789])}" = "%d samochodów policyjnych";
	
Powerful stuff, isn't it? :>

PS. There is built in solution for Polish language so you can use it with doing just this:

	"police-cars{one}" = "1 samochód policyjny";
	"police-cars{few}" = "%d samochody policyjne";
	"police-cars{many}" = "%d samochodów policyjnych";
	
	
This feature is called *"Shared Expression"* and is covered below.



## Shared Expressions

The functionality allows developer to observance of DRY principle and to avoid mistakes that exist because of reapeating the code in many places.

It is possible to create shared expression in your project and use it with no configuration with Swifternalization.

### Getting Started of Shared Expressions

1. Create *Expressions.strings* file in the same bundle when *Localizable.strings* file is.
2. Add shortcuts for your expressions and add your expressions ;)

Example:

	Localizable.strings (Base)
	-------------------
	"cars{custom-1}" = "%d car";
	"cars{custom-2}" = "%d cars";


	Localizable.strings (Polish)
	----------------------------
	"cars{custom-1}" = "%d samochód";
	"cars{custom-2}" = "%d samochody";
	"cars{custom-3}" = "%d samochodów";
	
	
	Expressions.strings (Base)
	--------------------------
	"custom-1" = "ie:%d=1";
	"custom-2" = "exp:(^[^1])|(^\\d{2,})";
	
	
	Expressions.strings (Polish)
	---------------------------
	"custom-1" = "ie:%d=1";
	"custom-2" = "exp:(((?!1).[2-4]{1})$)|(^[2-4]$)";
	"custom-3" = "exp:(.*(?=1).[0-9]$)|(^[05-9]$)|(.*(?!1).[0156789])";
	

Swifternalization load these *Expressions.strings* files and analyze them, and replace shortcuts for expressions with full expressions.

There is some duplication in Base and Polish version of expressions - *custom-1*. Instead of repeating this in entire language you want to cover you can keep it just in *Base* version of *Expressions.strings* file. Expressions that are find in *Base* and are not in preferred language file will be added to preferred language too to observance of DRY principle.

Swifternalization also handles the case of overriding built-in expressions. It gives you just few expressions for now like: `one`, `>one`, `two`, `other` as base expressions and `few` and `many` for Polish. If any of your *Expressions.strings* version of file will override it Swifternalization will use your version.

## Demo

There is demo project included in the repo. Just switch to proper target and run. It enumerated cars from 1 to 1000 and print them out to the console. Base (English) and Polish languages are supported. You can find there example of using simple primitive no-expression translation and also with experssions.

## Contribution and change or feature requests

Swifternalization is open sources so everyone may contribute if want to. If you want to develop it just fork the repo, do you work and create pull request. If you have some idea or question feel free to create issue and add proper tag for it.


## Built-in expressions

As mentioned in previous chapter Swifternalization has some built-in expressions and is ready to extend. If you want to add expressions specific for your country you can do it by creating class which conforms to `SharedExpressionProtocol`. Methods from protocol returns all expressions for your country. There is already `SharedBaseExpression` with some basic expressions and `SharedPolishExpression` with polish expressions for helping ordering numbers.

Example of the file ready for pull request should looks like this:

	class SharedPolishExpression: SharedExpressionProtocol {
	    static func allExpressions() -> [SharedExpression] {
	        return [
	            /**
	            (2-4), (22-24), (32-4), ..., (..>22, ..>23, ..>24)
	            
	            e.g.
	            - 22 samochody, 1334 samochody, 53 samochody
	            - 2 minuty, 4 minuty, 23 minuty
	            */
	            SharedExpression(k: "few", e: "exp:(((?!1).[2-4]{1})$)|(^[2-4]$)"),
	            
	            /**
	            0, (5-9), (10-21), (25-31), ..., (..0, ..1, ..5-9)
	            
	            e.g.
	            - 0 samochodów, 10 samochodów, 26 samochodów, 1147 samochodów
	            - 5 minut, 18 minut, 117 minut, 1009 minut
	            */
	            SharedExpression(k: "many", e: "exp:(.*(?=1).[0-9]$)|(^[05-9]$)|(.*(?!1).[0156789])"),
	        ]
	    }
	}


Also this is required to cover all shared expressions for a country with unit tests. You can find examples in the repo for e.g. Polish expressions.

## Swift 2

Swifternalization supports Swift 2 and works on Xcode 7 beta 2. Please check *swift2* branch for that.


## Things to do in future release:
- Add more built-in expressions for another countries.

## LICENSE

Swifternalization is released under the MIT license.

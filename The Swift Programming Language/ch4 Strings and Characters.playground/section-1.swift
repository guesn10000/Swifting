/*
 * 4.1 Preview
 */

// String type, which in turn represents a collection of values of Character type.

// Swift’s String type is bridged seamlessly to Foundation’s NSString class.
// For more information about using String with Foundation and Cocoa, see << Using Swift with Cocoa and Objective-C >>.


/*
 * 4.2 String Literals
 */

/*
String literals can include the following special characters:
1.The escaped special characters 
    \0 (null character), 
    \\ (backslash), 
    \t (horizontal tab), 
    \n (line feed), 
    \r (carriage return), 
    \" (double quote),
    \' (single quote)
2.Single-byte Unicode scalars, written as \xnn, where nn is two hexadecimal digits
3.Two-byte Unicode scalars, written as \unnnn, where nnnn is four hexadecimal digits
4.Four-byte Unicode scalars, written as \Unnnnnnnn, where nnnnnnnn is eight hexadecimal digits
 */
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
let dollarSign = "\x24"        // $,  Unicode scalar U+0024
let blackHeart = "\u2665"      // ♥,  Unicode scalar U+2665
let sparklingHeart = "\U0001F496"  // 💖, Unicode scalar U+1F496

println(sparklingHeart + sparklingHeart + sparklingHeart)



/*
 * 4.3 Initializing an Empty String
 */

// these two strings are both empty, and are equivalent to each other
var emptyString = ""               // empty string literal
var anotherEmptyString = String()  // initializer syntax

// find out whether a String value is empty
if emptyString.isEmpty {
    println("Nothing to see here")
}


/*
 * 4.4 String Mutability
 */

var variableString = "Horse"
variableString += " and carriage"

let constantString = "Highlander"
//constantString += " and another Highlander" // Error


/*
 * 4.5 Strings Are Value Types
 */

// String在Swfit中是按值传递的：Swift’s String type is a value type. If you create a new String value, that String value is copied when it is passed to a function or method, or when it is assigned to a constant or variable. In each case, a new copy of the existing String value is created, and the new copy is passed or assigned, not the original version.

// 优点：Swift’s copy-by-default String behavior ensures that when a function or method passes you a String value, it is clear that you own that exact String value, regardless of where it came from. You can be confident that the string you are passed will not be modified unless you modify it yourself.

// 不用担心，编译器会做优化：Behind the scenes, Swift’s compiler optimizes string usage so that actual copying takes place only when absolutely necessary. This means you always get great performance when working with strings as value types.


/*
 * 4.6 Working with Characters
 */

for character in "Dog!🐶" {
    println(character)
}

let yuanSign: Character = "¥"

// Counting Characters
let helloMessage = "😄😊"
println("helloMessage has \(countElements(helloMessage)) characters") // 2个字符
// Different Unicode characters and different representations of the same Unicode character can require different amounts of memory to store. Because of this, characters in Swift do not each take up the same amount of memory within a string’s representation.So the countElements function must iterate over the characters within a string in order to calculate an accurate character count for that string.
// Note also that the character count returned by countElements is not always the same as the length property of an NSString that contains the same characters.


/*
 * 4.7 Concatenating（串联） Strings and Characters
 */

let 字符串1 = "字符串1"
let 字符串2 = "字符串2"
let 字符1: Character = "1"
let 字符2: Character = "2"
let 字符串1加字符1 = 字符串1 + 字符1
let 字符1加字符串1 = 字符1 + 字符串1
let 字符1加字符2 = 字符1 + 字符2
let 字符串1加字符串2 = 字符串1 + 字符串2

let character1 = "!"
var welcome = "good morning"
welcome += character1

// You can’t append a String or Character to an existing Character variable, because a Character value must contain a single character only.
var char: Character = "c"
//char += "1" // Error


/*
 * 4.8 String Interpolation（插入）
 */

let multiplier = 3
let messageInterpolation = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"


/*
 * 4.9 Comparing Strings
 */

// String Equality
let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
    println("These two strings are considered equal")
}

// Prefix and Suffix Equality
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 1 Scene 6: The Great Wall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]
var act1SceneCount = 0
var mansionCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") { // 前缀
        ++act1SceneCount
    }
    if scene.hasSuffix("Capulet's mansion") { // 后缀
        ++mansionCount
    }
}
act1SceneCount
mansionCount


/*
 * 4.10 Uppercase and Lowercase Strings
 */

let normal = "Could you help me, please?"
let shouty = normal.uppercaseString
let whispered = normal.lowercaseString


/*
 * 4.11 Unicode, UTF-8 and UTF-16
 */

let dogString = "Dog!🐶"

// You can access a UTF-8 representation of a String by iterating over its utf8 property.
for codeUnit in dogString.utf8 {
    print("\(codeUnit) ")
}
print("\n")

// You can access a UTF-16 representation of a String by iterating over its utf16 property.
for codeUnit in dogString.utf16 {
    print("\(codeUnit) ")
}
print("\n")

// You can access a Unicode scalar（标量） representation of a String value by iterating over its unicodeScalars property.
for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ") // Each UnicodeScalar has a value property that returns the scalar’s 21-bit value, represented within a UInt32 value
}
print("\n")
for scalar in dogString.unicodeScalars {
    println("\(scalar) ")
}
print("\n")


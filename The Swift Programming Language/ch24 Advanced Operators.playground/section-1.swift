/*
 * 24.1 Bitwise Operators
 */

// 1.Bitwise NOT Operator
let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits // equals 11110000

// 2.Bitwise AND Operator
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8  = 0b00111111
let middleFourBits = firstSixBits & lastSixBits  // equals 00111100

// 3.Bitwise OR Operator
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedbits = someBits | moreBits  // equals 11111110

// 4.Bitwise XOR Operator
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits  // equals 00010001

// 5.Bitwise Left and Right Shift Operators
let shiftBits: UInt8 = 4   // 00000100 in binary
shiftBits << 1             // 00001000
shiftBits << 2             // 00010000
shiftBits << 5             // 10000000
shiftBits << 6             // 00000000
shiftBits >> 2             // 00000001

let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16    // redComponent is 0xCC, or 204
let greenComponent = (pink & 0x00FF00) >> 8   // greenComponent is 0x66, or 102
let blueComponent = pink & 0x0000FF           // blueComponent is 0x99, or 153

// 注意区分逻辑移位和算术移位


/*
 * 24.2 Overflow Operators
 */

/*
var potentialOverflow = Int16.max
// potentialOverflow equals 32767, which is the largest value an Int16 can hold
potentialOverflow += 1
// this causes an error
 */

// 1.Value Overflow
var willOverflow = UInt8.max
// willOverflow equals 255, which is the largest value a UInt8 can hold
willOverflow = willOverflow &+ 1
// willOverflow is now equal to 0

// 2.Value Underflow
var willUnderflow = UInt8.min
// willUnderflow equals 0, which is the smallest value a UInt8 can hold
willUnderflow = willUnderflow &- 1
// willUnderflow is now equal to 255

var signedUnderflow = Int8.min
// signedUnderflow equals -128, which is the smallest value an Int8 can hold
signedUnderflow = signedUnderflow &- 1
// signedUnderflow is now equal to 127

// 3.Division by Zero
let x = 1
//let y = x / 0 // Error
let y = x &/ 0
// y is equal to 0


/*
 * 24.3 Precedence（优先级） and Associativity（结合性）
 */

2 + 3 * 4 % 5

/*
NOTE:swift’s operator precedences and associativity rules are simpler and more predictable than those found in C and Objective-C. However, this means that they are not the same as in C-based languages. Be careful to ensure that operator interactions still behave in the way you intend when porting existing code to Swift.
 */


/*
 * 24.4 Operator Functions
 */

/*
Classes and structures can provide their own implementations of existing operators. This is known as overloading（重载） the existing operators.
 */

struct Vector2D {
    var x = 0.0, y = 0.0
}

@infix func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}
let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector


/*
 * 24.5 Prefix and Postfix Operators
 */

@prefix func - (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
}
let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
let alsoPositive = -negative


/*
 * 24.6 Compound Assignment Operators
 */

/*
Compound assignment operators combine assignment (=) with another operation. For example, the addition assignment operator (+=) combines addition and assignment into a single operation. Operator functions that implement compound assignment must be qualified with the @assignment attribute. You must also mark a compound assignment operator’s left input parameter as inout, because the parameter’s value will be modified directly from within the operator function.
 */

@assignment func += (inout left: Vector2D, right: Vector2D) {
    left = left + right
}

var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd

@prefix @assignment func ++ (inout vector: Vector2D) -> Vector2D {
    vector += Vector2D(x: 1.0, y: 1.0)
    return vector
}
var toIncrement = Vector2D(x: 3.0, y: 4.0)
let afterIncrement = ++toIncrement

/*
NOTE:it is not possible to overload the default assignment operator (=). Only the compound assignment operators can be overloaded. Similarly, the ternary conditional operator (a ? b : c) cannot be overloaded.
 */


/*
 * 24.7 Equivalence Operators
 */

@infix func == (left: Vector2D, right: Vector2D) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}
@infix func != (left: Vector2D, right: Vector2D) -> Bool {
    return !(left == right)
}
let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
twoThree == anotherTwoThree


/*
 * 24.8 Custom Operators
 */

/*
You can declare and implement your own custom operators in addition to the standard operators provided by Swift. Custom operators can be defined only with the characters / = - + * % < > ! & | ^ . ~.
New operators are declared at a global level using the operator keyword, and can be declared as prefix, infix or postfix.
 */

operator prefix +++ {}
@prefix @assignment func +++ (inout vector: Vector2D) -> Vector2D {
    vector += vector
    return vector
}
var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled


/*
 * 24.9 Precedence and Associativity for Custom Infix Operators（中缀运算符）
 */

/*
Custom infix operators can also specify a precedence and an associativity.

The associativity value defaults to none if it is not specified. The precedence value defaults to 100 if it is not specified.
 */

operator infix +- { associativity left precedence 140 }
func +- (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y - right.y)
}
let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector

/*
For a complete list of the default Swift operator precedence and associativity settings, see Expressions.
 */


/*
 * 3.1 Preview
 */

// operator (=) does not return a value, to prevent it from being mistakenly used when the equal to operator (==) is intended.

// Arithmetic operators (+, -, *, /, % and so forth) detect and disallow value overflow, to avoid unexpected results when working with numbers that become larger or smaller than the allowed value range of the type that stores them.

// Swift lets you perform remainder (%) calculations on floating-point numbers.


/*
 * 3.2 Assignment Operator
 */

//if x = y { // this is not valid, because x = y does not return a value
//}


/*
 * 3.3 Arithmetic Operators
 */

let 🐶: Character = "🐶"
let 🐮: Character = "🐮"
let 🐶🐮 = 🐶 + 🐮


/*
 * 3.4 Remainder Operator
 */

// The sign of b is ignored for negative values of b. This means that a % b and a % -b always give the same answer.
-9 % 4
9 % -4
8 % 2.5


/*
 * 3.4 Increment and Decrement Operators
 */

var a = 0
let b = ++a
let c = a++
a


/*
 * 3.5 Unary（单目运算符中的单个） Minus Operator and Unary Plus Operator
 */

let minusThree = -3
let three = +minusThree // The unary plus operator (+) simply returns the value it operates on, without any change


/*
 * 3.6 Compound Assignment Operators
 */

var d = 0
d += 2 // 使用+=之前必须初始化原来的变量，否则会报错


/*
 * 3.7 Comparison Operators
 */

1 == 1   // true, because 1 is equal to 1
2 != 1   // true, because 2 is not equal to 1
2 > 1    // true, because 2 is greater than 1
1 < 2    // true, because 1 is less than 2
1 >= 1   // true, because 1 is greater than or equal to 1
2 <= 1   // false, because 2 is not less than or equal to
let name = "world"
name == "world"


/*
 * 3.8 Ternary Conditional Operator（多目运算符）
 */

// :?
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)


/*
 * 3.9 Range Operators
 */

// Closed Range Operator
var sum = 0
for index in 1...3 {
    sum += index
}
sum

// Half-Closed Range Operator
sum = 0
for index in 1..3 {
    sum += index
}
sum


/*
 * 3.10 Logical Operators
 */

let b1 = true
let b2 = false
let b3 = true
let b4 = false
if b1 && b2 || b3 || b4 { // 从左往右计算
    println("Welcome!")
} else {
    println("ACCESS DENIED")
}



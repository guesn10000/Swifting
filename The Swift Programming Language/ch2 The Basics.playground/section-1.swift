/*
 * 2.1 Preview
 */

// Optionals are similar to using nil with pointers in Objective-C, but they work for any type, not just classes.

// Swift is a type safe language. Swift helps you to be clear about the types of values your code can work with.


/*
 * 2.2 Declaring Constants and Variables
 */

// declare
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0

// declare multiple constants or multiple variables on a single line, separated by commas
var x = 0.0, y = 0.0, z = 0.0


/*
 * 2.3 Type Annotations
 */

var welcomeMessage: String // 如果声明了类型，那么可以不用赋初值，可以看出赋初值的作用在于让编译器知道该变量的类型
welcomeMessage = "Hello"


/*
 * 2.4 Naming Constants and Variables
 */

// You can use almost any character you like for constant and variable names, including Unicode characters
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"
// 命名的禁忌规则
// Constant and variable names cannot contain mathematical symbols, arrows, private-use (or invalid) Unicode code points, or line- and box-drawing characters. Nor can they begin with a number, although numbers may be included elsewhere within the name.

// If you need to give a constant or variable the same name as a reserved Swift keyword, you can do so by surrounding the keyword with back ticks (`) when using it as a name. However, you should avoid using keywords as names unless you have absolutely no choice.
var `String` = "keywords String"


/*
 * 2.5 Printing Constants and Variables
 */

println("This is a string")
println("The current value of friendlyWelcome is \(你好)")


/*
 * 2.5 Comments
 */

// this is a comment
/* this is also a comment,
but written over multiple lines */

// 注释可以嵌套，这个逆天了
/*
    var a = 0 // 外层的注释 开头
    /* 内层的注释 */
    var b = 1 // 外层的注释 结尾
 */


/*
 * 2.6 Semicolons（分号）
 */

let dog = "🐶" // 不要求每个语句都用分号结尾
let cat = "🐱"; println(cat) // 同一行的多个语句必须用分号分隔开来


/*
 * 2.7 Integers
 */

// Swift provides signed and unsigned integers in 8, 16, 32, and 64 bit forms. These integers follow a naming convention similar to C, in that an 8-bit unsigned integer is of type UInt8, and a 32-bit signed integer is of type Int32. Like all types in Swift, these integer types have capitalized names.

// access the minimum and maximum values of each integer type
let minValue = UInt8.min
let maxValue = UInt8.max

// On a 32-bit platform, Int is the same size as Int32.
// On a 64-bit platform, Int is the same size as Int64.
let minInt32Value = Int32.min
let minInt64Value = Int64.min
// Unless you need to work with a specific size of integer, always use Int for integer values in your code. This aids code consistency and interoperability.

// Use UInt only when you specifically need an unsigned integer type with the same size as the platform’s native word size. If this is not the case, Int is preferred.
// A consistent use of Int for integer values aids code interoperability, avoids the need to convert between different number types, and matches integer type inference


/*
 * 2.8 Floating-Point Numbers
 */

// Double represents a 64-bit floating-point number. Use it when floating-point values must be very large or particularly precise.
// Float represents a 32-bit floating-point number. Use it when floating-point values do not require 64-bit precision.
// Double has a precision of at least 15 decimal digits, whereas the precision of Float can be as little as 6 decimal digits.


/*
 * 2.9 Type Safety and Type Inference
 */

// Because Swift is type safe, it performs type checks when compiling your code and flags any mismatched types as errors.

// Because of type inference, Swift requires far fewer type declarations than languages such as C or Objective-C. Constants and variables are still explicitly typed, but much of the work of specifying their type is done for you.

// Swift always chooses Double (rather than Float) when inferring the type of floating-point numbers.
let pi = 3.14159
// pi is inferred to be of type Double”


/*
 * 2.10 Numeric Literals
 */

// 各种进制数
let decimalInteger = 18
let binaryInteger = 0b10010       // 18 in binary notation
let octalInteger = 0o22           // 18 in octal notation
let hexadecimalInteger = 0x12     // 18 in hexadecimal notation

// optional exponent, indicated by an uppercase or lowercase e for decimal floats, or an uppercase or lowercase p for hexadecimal floats. 
// 例如：0xFp2 means 15 × (2 ^ 2), or 60.0. 1.25e2 means 1.25 × (10 ^ 2), or 125.0.
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0

// Numeric literals can contain extra formatting to make them easier to read. Both integers and floats can be padded with extra zeroes and can contain underscores to help with readability.
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1


/*
 * 2.11 Numeric Type Conversion
 */

// 更加安全的类型推断，不存在隐式的Integer Conversion
// let cannotBeNegative: UInt8 = -1 // UInt8不能存储负数，报错
// let tooBig: Int8 = Int8.max + 1 // 溢出，报错
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
//let twoThousandAndOne_Error = twoThousand + one // 不允许两个类型不同的整数相加，报错
let twoThousandAndOne = twoThousand + UInt16(one) //必须进行UInt8 to UInt16的强制类型转换
// SomeType(ofInitialValue) is the default way to call the initializer of a Swift type and pass in an initial value.

// Integer and Floating-Point Conversion
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi_double = Double(three) + pointOneFourOneFiveNine
// pi equals 3.14159, and is inferred to be of type Double
let pi_integer = Int(pi_double)
// integerPi equals 3, and is inferred to be of type Int. Floating-point values are always truncated when used to initialize a new integer value in this way. This means that 4.75 becomes 4, and -3.9 becomes -3.


/*
 * 2.12 Type Aliases（类型别名）
 */

// typealias相当于typedef
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min


/*
 * 2.13 Booleans
 */

// Bool类型值为true和false，不再是YES和NO
let orangesAreOrange = true
let turnipsAreDelicious = false

// Swift’s type safety prevents non-Boolean values from being be substituted for Bool.
let b = 1
//if i { // this example will not compile, and will report an error
if b == 1 { // this example will compile successfully
}


/*
 * 2.14 Tuples
 */

// Tuples are particularly useful as the return values of functions.

// create a (Int, String) tuple
let http404Error = (404, "Not Found")
let http200Status = (statusCode: 200, description: "OK") // name the individual elements in a tuple

// decompose a tuple’s contents
let (statusCode, statusMessage) = http404Error
println("The status code is \(statusCode)")
println("The status message is \(statusMessage)")

// If you only need some of the tuple’s values, ignore parts of the tuple with an underscore (_) when you decompose the tuple
let (justTheStatusCode, _) = http404Error
println("The status code is \(justTheStatusCode)")

// access the individual element values in a tuple
println("The status code is \(http404Error.0)")
println("The status message is \(http404Error.1)")

// If you name the elements in a tuple, you can use the element names to access the values of those elements
println("The status code is \(http200Status.statusCode)")
println("The status message is \(http200Status.description)")

// 比较元组和类/结构体：Tuples are useful for temporary groups of related values. They are not suited to the creation of complex data structures. If your data structure is likely to persist beyond a temporary scope, model it as a class or structure, rather than as a tuple.


/*
 * 2.15 If Statements and Forced Unwrapping
 */

// Swift’s optionals work for absence of a value for any type
let possibleString = "Hello"
let possibleNumber = "123"
var convertedNumber = possibleString.toInt() // nil
convertedNumber = possibleNumber.toInt() // 123
// convertedNumber is inferred to be of type "Int?", or "optional Int

// Once you’re sure that the optional does contain a value, you can access its underlying value by adding an exclamation mark (!) to the end of the optional’s name. The exclamation mark effectively says, “I know that this optional definitely has a value; please use it.” This is known as forced unwrapping of the optional’s value
if convertedNumber {
    println("\(possibleNumber) has an integer value of \(convertedNumber!)")
} else {
    println("\(possibleString) could not be converted to an integer")
}

// Trying to use ! to access a non-existent optional value triggers a runtime error. Always make sure that an optional contains a non-nil value before using ! to force-unwrap its value.
convertedNumber = nil
//println("\(convertedNumber!)")
/*
报错信息如下：
fatal error: Can't unwrap Optional.None
Playground execution failed: error: Execution was interrupted, reason: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0).
The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.
* thread #1: tid = 0x18840, 0x000000010b451b1f, queue = 'com.apple.main-thread', stop reason = EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0)
* frame #0: 0x000000010b451b1f
 */


/*
 * 2.16 Optional Binding
 */

// use optional binding to find out whether an optional contains a value
if let actualNumber = possibleNumber.toInt() {
    println("\(possibleNumber) has an integer value of \(actualNumber)")
} else {
    // 注意在本分支中不能使用actualNumber，无论其是constant还是variable
    println("\(possibleNumber) could not be converted to an integer")
}
/*
 "let actualNumber = possibleNumber.toInt()" can be read as:
 If the optional Int returned by possibleNumber.toInt contains a value, set a new constant called actualNumber to the value contained in the optional. Else switch to else branch.
 */


/*
 * 2.17 nil
 */

var serverResponseCode: Int? = 404 // 注意如果Int后没有问号，表示该变量不能为nil，下面赋值为nil将会报错
serverResponseCode = nil

// If you define an optional constant or variable without providing a default value, the constant or variable is automatically set to nil for you
var surveyAnswer: String?

// Swift中的nil对比OC中的nil: Swift’s nil is not the same as nil in Objective-C. In Objective-C, nil is a pointer to a non-existent object. In Swift, nil is not a pointer—it is the absence of a value of a certain type. Optionals of any type can be set to nil, not just object types.


/*
 * 2.18 Implicitly Unwrapped Optionals
 */

// write an implicitly unwrapped optional by placing an exclamation mark (String!) rather than a question mark (String?)
let possibleNilString: String? = "An optional string."
println(possibleNilString!) // requires an exclamation mark to access its value
var assumedString: String! = "An implicitly unwrapped optional string."
println(assumedString) // no exclamation mark is needed to access its value
assumedString = nil
println(assumedString) // 不会报错，访问的是nil
//println(assumedString!) // 报错
// 事实上，Implicitly unwrapped optionals should not be used when there is a possibility of a variable becoming nil at a later point.


/*
 * 2.19 Debugging with Assertions
 */

var age = 0
assert(age >= 0, "A person's age cannot be less than zero")
/*
如果age = 3，断言的报错信息：
assertion failed: A person's age cannot be less than zero: file <REPL>, line 302
Playground execution failed: error: Execution was interrupted, reason: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0).
The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.
* thread #1: tid = 0x1d7bb, 0x000000010a7be84e, queue = 'com.apple.main-thread', stop reason = EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0)
* frame #0: 0x000000010a7be84e
 */

/*
Suitable scenarios for an assertion check include:
1.An integer subscript（下标） index is passed to a custom subscript implementation, but the subscript index value could be too low or too high.
2.A value is passed to a function, but an invalid value means that the function cannot fulfill（执行） its task.
3.An optional value is currently nil, but a non-nil value is essential（必要的） for subsequent（随后的） code to execute successfully.
 */

// an assertion is an effective way to ensure that such conditions are highlighted and noticed during development, before your app is published. 要发布应用的话必须要去掉所有的断言


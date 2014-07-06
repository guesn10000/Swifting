/*
 * 7.1 Defining and Calling Functions
 */

func sayHello(personName: String) -> String {
    let greeting = "Hello, " + personName + "!"
    return greeting
}
sayHello("Brian")

func sayHelloAgain(personName: String) -> String {
    return "Hello again, " + personName + "!"
}
sayHelloAgain("Brian")


/*
 * 7.2 Function Parameters and Return Values
 */

// Multiple Input Parameters
func halfOpenRangeLength(start: Int, end: Int) -> Int {
    return end - start
}
halfOpenRangeLength(1, 10)

// Functions Without Parameters
func sayHelloWorld() -> String {
    return "hello, world"
}
sayHelloWorld()

// Functions Without Return Values
func sayGoodbye(personName: String) {
    println("Goodbye, \(personName)!")
}
sayGoodbye("Dave")
/*
注意：
Strictly speaking, the sayGoodbye function does still return a value, even though no return value is defined. Functions without a defined return type return a special value of type Void. This is simply an empty tuple, in effect a tuple with zero elements, which can be written as ().
 */

// A function with a defined return type cannot allow control to fall out of the bottom of the function without returning a value, and attempting to do so will result in a compile-time error.（例如在函数中连续添加两行return，那么后一个return行上会被编译器警告）

// Functions with Multiple Return Values: You can use a tuple type as the return type for a function to return multiple values as part of one compound return value.
func count(string: String) -> (vowels: Int, consonants: Int, others: Int) {
    var vowels = 0, consonants = 0, others = 0
    for character in string {
        switch String(character).lowercaseString {
        case "a", "e", "i", "o", "u":
            ++vowels
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
        "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            ++consonants
        default:
            ++others
        }
    }
    return (vowels, consonants, others)
}
let total = count("some arbitrary string!") // 这里total是一个tuple
total.vowels
total.consonants
total.2


/*
 * 7.3 Function Parameter Names
 */

/*
local parameter names

func someFunction(parameterName: Int) {
    // function body goes here, and can use parameterName
    // to refer to the argument value for that parameter
}
 */

/*
external parameter name

func someFunction(externalParameterName localParameterName: Int) { // external参数名和local参数名之间用空格隔开
    // function body goes here, and can use localParameterName
    // to refer to the argument value for that parameter
}

If you provide an external parameter name for a parameter, that external name must always be used when calling the function. 这样可以提高代码的可读性，保留了OC的优点。
 */
func join(string s1: String, toString s2: String, withJoiner joiner: String)
    -> String {
        return s1 + joiner + s2
}
//join("hello", "world", ", ") // 报错：没有指定external参数名
join(string: "hello", toString: "world", withJoiner: ", ")

// 什么时候该用external参数名？ Consider using external parameter names whenever the purpose of a function’s arguments would be unclear to someone reading your code for the first time. You do not need to specify external parameter names if the purpose of each parameter is clear and unambiguous when the function is called.

// Shorthand（速记） External Parameter Names: prefix the name with a hash symbol (#). This tells Swift to use that name as both the local parameter name and the external parameter name.
func containsCharacter(#string: String, #characterToFind: Character) -> Bool {
    for character in string {
        if character == characterToFind {
            return true
        }
    }
    return false
}
let containsAVee = containsCharacter(string: "aardvark", characterToFind: "v")
//containsCharacter("aardvark",  "v") // 报错

// Default Parameter Values
func join_default(string s1: String, toString s2: String,
    withJoiner joiner: String = ", ") -> String {
        return s1 + joiner + s2
}
join_default(string: "hello", toString: "world", withJoiner: " ")
join_default(string: "hello", toString: "world")

// External Names for Parameters with Default Values: Swift provides an automatic external name for any defaulted parameter you define, if you do not provide an external name yourself
func join_externalDefault(s1: String, s2: String, joiner: String = " ") -> String {
    return s1 + joiner + s2
}
join_externalDefault("hello", "world", joiner: "-")
//join_externalDefault("hello", "world",  "-") // 报错

// Variadic Parameters（可变参数）: A variadic parameter accepts zero or more values of a specified type. Write variadic parameters by inserting three period characters (...) after the parameter’s type name.
// a variadic parameter with a name of numbers and a type of Double... is made available within the function’s body as a constant array called numbers of type Double[].
func arithmeticMean(numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
arithmeticMean(3, 8, 19)
// 注意：A function may have at most one variadic parameter, and it must always appear last in the parameter list, to avoid ambiguity when calling the function with multiple parameters. If your function has one or more parameters with a default value, and also has a variadic parameter, place the variadic parameter after all the defaulted parameters at the very end of the list.

// Constant and Variable Parameters: 函数中的参数以常数形式出现，如果要改变它的值，必须要用var声明，在传值进来的时候会做一个可变的copy
func alignRight(var string: String, count: Int, pad: Character) -> String {
//    count = 100 // 报错：count是constant
    let amountToPad = count - countElements(string)
    for _ in 1...amountToPad {
        string = pad + string
    }
    return string
    // The variable parameter only exists for the lifetime of that function call.
}
let originalString = "hello"
let paddedString = alignRight(originalString, 10, "-")

// In-Out Parameters（类似于传递参数的引用）: If you want a function to modify a parameter’s value, and you want those changes to persist after the function call has ended, define that parameter as an in-out parameter instead.
// You can only pass a variable as the argument for an in-out parameter. You cannot pass a constant or a literal value as the argument, because constants and literals cannot be modified. You place an ampersand (&) directly before a variable’s name when you pass it as an argument to an inout parameter, to indicate that it can be modified by the function.
// In-out parameters cannot have default values, and variadic parameters cannot be marked as inout. If you mark a parameter as inout, it cannot also be marked as var or let.
func swapTwoInts(inout a: Int, inout b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
someInt
anotherInt
//swapTwoInts(someInt, anotherInt) // 报错：传给inout参数的值必须用&声明
/*
总结：
In-out parameters are not the same as returning a value from a function. The swapTwoInts example above does not define a return type or return a value, but it still modifies the values of someInt and anotherInt. In-out parameters are an alternative way for a function to have an effect outside of the scope of its function body.
 */


/*
 * 7.4 Function Types
 */

func addTwoInts(a: Int, b: Int) -> Int { // The type of this functions is (Int, Int) -> Int
    return a + b
}
func multiplyTwoInts(a: Int, b: Int) -> Int {
    return a * b
}
func printHelloWorld() { // The type of this function is () -> (), functions that don’t specify a return value always return Void, which is equivalent to an empty tuple in Swift, shown as ().
    println("hello, world")
}

// Using Function Types
var mathFunction: (Int, Int) -> Int = addTwoInts
mathFunction(3, 3)
mathFunction = multiplyTwoInts
mathFunction(3, 3)
let anotherMathFunction = addTwoInts

// Function Types as Parameter Types
func getMathResult(mathFunction: (Int, Int) -> Int, a: Int, b: Int) -> Int {
    return mathFunction(a, b)
}
getMathResult(addTwoInts, 3, 5)

// Function Types as Return Types
func stepForward(input: Int) -> Int {
    return input + 1
}
func stepBackward(input: Int) -> Int {
    return input - 1
}
func chooseStepFunction(backwards: Bool) -> ((Int) -> Int) {
    return backwards ? stepBackward : stepForward
}
var currentValue = 3
let moveNearerToZero = chooseStepFunction(currentValue > 0)
moveNearerToZero(1)


/*
 * 7.5 Nested（嵌套） Functions
 */

// You can also define functions inside the bodies of other functions, known as nested functions.
func chooseStepFunction_nested(backwards: Bool) -> ((Int) -> Int) {
    func stepForward_nested(input: Int) -> Int { return input + 1 }
    func stepBackward_nested(input: Int) -> Int { return input - 1 }
    return backwards ? stepBackward_nested : stepForward_nested
}
let moveNearerToZero_nested = chooseStepFunction_nested(currentValue > 0)
moveNearerToZero_nested(1)


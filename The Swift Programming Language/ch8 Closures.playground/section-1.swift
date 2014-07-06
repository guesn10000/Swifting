/*
 * 8.1 Preview
 */

// Closures are self-contained blocks of functionality that can be passed around and used in your code. Closures can capture and store references to any constants and variables from the context in which they are defined. Swift handles all of the memory management of capturing for you.

/*
Closures（闭包） take one of three forms:
1.Global functions are closures that have a name and do not capture any values.
2.Nested functions are closures that have a name and can capture values from their enclosing function.
3.Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.
 */


/*
 * 8.2 The Sort Function
 */

func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
var reversed = sort(names, backwards)


/*
 * 8.3 Closure Expression Syntax
 */

/*
{ (parameters) -> return type in
    statements
}

Closure expression syntax can use constant parameters, variable parameters, and inout parameters. Default values cannot be provided. Variadic parameters can be used if you name the variadic parameter and place it last in the parameter list. Tuples can also be used as parameter types and return types.
 */
reversed = sort(names, {
    (s1: String, s2: String) -> Bool
        in
    return s1 > s2
    })

// Inferring Type From Context: it is always possible to infer parameter types and return type when passing a closure to a function as an inline closure expression.
reversed = sort(names, { s1, s2 in return s1 > s2 } )

// Single-expression closures can implicitly return the result of their single expression by omitting the return keyword from their declaration
reversed = sort(names, { s1, s2 in s1 > s2 })

// Shorthand Argument Names: if you use these shorthand argument names within your closure expression, you can omit the closure’s argument list from its definition, and the number and type of the shorthand argument names will be inferred from the expected function type. The in keyword can also be omitted, because the closure expression is made up entirely of its body
reversed = sort(names, { $0 > $1 } )

// Operator Functions: you can simply pass in the greater-than operator, and Swift will infer that you want to use its string-specific implementation
reversed = sort(names, >)


/*
 * 8.4 Trailing Closures
 */

// If you need to pass a closure expression to a function as the function’s final argument and the closure expression is long, it can be useful to write it as a trailing closure instead. 例如：
func someFunctionThatTakesAClosure(closure: () -> ()) {
    // function body goes here
}

// here's how you call this function without using a trailing closure:
someFunctionThatTakesAClosure({
    // closure's body goes here
    })

// here's how you call this function with a trailing closure instead:
someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}

// A trailing closure is a closure expression that is written outside of (and after) the parentheses of the function call it supports
reversed = sort(names) { $0 > $1 }

// If a closure expression is provided as the function’s only argument and you provide that expression as a trailing closure, you do not need to write a pair of parentheses () after the function’s name when you call the function.
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]
let strings = numbers.map {
    (var number) -> String in
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}


/*
 * 8.5 Capturing Values
 */

// Swift determines what should be captured by reference and what should be copied by value. Swift also handles all memory management involved in disposing
func makeIncrementor(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
        // Because it does not modify amount, incrementor actually captures and stores a copy of the value stored in amount. This value is stored along with the new incrementor function.
        // However, because it modifies the runningTotal variable each time it is called, incrementor captures a reference to the current runningTotal variable, and not just a copy of its initial value. Capturing a reference ensures sure that runningTotal does not disappear when the call to makeIncrementor ends
    }
    return incrementor
}
let incrementByTen = makeIncrementor(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()

// If you create another incrementor, it will have its own stored reference to a new, separate runningTotal variable
let incrementBySeven = makeIncrementor(forIncrement: 7)
incrementBySeven()
incrementByTen()
incrementBySeven()
incrementBySeven()

/*
类似于retain cycle的问题：
If you assign a closure to a property of a class instance, and the closure captures that instance by referring to the instance or its members, you will create a strong reference cycle between the closure and the instance. Swift uses capture lists to break these strong reference cycles. For more information, see Strong Reference Cycles for Closures.
 */


/*
 * 8.6 Closures Are Reference Types
 */

/*
In the example above, incrementBySeven and incrementByTen are constants, but the closures these constants refer to are still able to increment the runningTotal variables that they have captured. This is because functions and closures are reference types.

In the example above, it is the choice of closure that incrementByTen refers to that is constant, and not the contents of the closure itself.

This also means that if you assign a closure to two different constants or variables, both of those constants or variables will refer to the same closure

简单来说，incrementByTen是闭包的引用，是一个常量，自身不可变。但闭包自身的内容是可变的。当把一个闭包引用赋值给另外一个引用，那么他们指向相同的闭包。见下面的例子。
 */
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()
incrementByTen()
//alsoIncrementByTen = incrementBySeven // 报错，闭包引用是常量，不能再向它赋新的值


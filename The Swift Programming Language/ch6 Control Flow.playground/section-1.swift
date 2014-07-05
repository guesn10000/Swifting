/*
 * 6.1 For-in Loops
 */

// If you don’t need each value from the range, you can ignore the values by using an underscore in place of a variable name
let base = 2
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
base
power
answer

// iterate over the Character values in a string
for character in "Hello" {
    println(character)
}


/*
 * 6.2 For-Condition-Increment
 */

/*
形式如下：
for initialization; condition; increment {
    statements
}
 */
for var index = 0; index < 3; ++index {
    println("index is \(index)")
}



/*
 * 6.3 While Loops
 */

/*
形式如下：
while condition {
    statements
}
或
do {
    statements
} while condition
 */


/*
 * 6.4 Switch
 */

/*
形式如下：
switch some value to consider {
    case value 1:
        respond to value 1
    case value 2, value 3:
        respond to value 2 or 3
    default:
        otherwise, do something else
}
 */
let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
    println("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
"n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    println("\(someCharacter) is a consonant")
default:
    println("\(someCharacter) is not a vowel or a consonant")
}

// switch statements in Swift do not fall through the bottom of each case and into the next one by default.
// Instead, the entire switch statement finishes its execution as soon as the first matching switch case is completed, without requiring an explicit break statement. This makes the switch statement safer and easier to use than in C, and avoids executing more than one switch case by mistake.
let anotherCharacter: Character = "A"
switch anotherCharacter {
//case "a": // Error
case "A":
    println("The letter A")
    break // break语句不是必须的
default:
    println("Not the letter A")
}


/*
 * 6.5 Range Matching
 */

let count = 3_000_000_000_000
let countedThings = "stars in the Milky Way"
var naturalCount: String
switch count {
case 0:
    naturalCount = "no"
case 1...3:
    naturalCount = "a few"
case 4...9:
    naturalCount = "several"
case 10...99:
    naturalCount = "tens of"
case 100...999:
    naturalCount = "hundreds of"
case 1000...999_999:
    naturalCount = "thousands of"
default:
    naturalCount = "millions and millions of"
}


/*
 * 6.6 Tuples
 */

// use the underscore (_) identifier to match any possible value.
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    println("(0, 0) is at the origin")
case (_, 0):
    println("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    println("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    println("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    println("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}
// 注：somePoint是元组，somePoint.0或somePoint.1表示取该元组中的第一个或第二个元素


/*
 * 6.7 Value Bindings
 */

// A switch case can bind the value or values it matches to temporary constants or variables, for use in the body of the case. This is known as value binding
let anotherPoint = (2, 1)
switch anotherPoint {
case (let x, 0):
    x
case (0, let y):
    y
case let (x, y):
    (x, y)
}


/*
 * 6.8 Where
 */

// A switch case can use a where clause to check for additional conditions.
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    println("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    println("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    println("(\(x), \(y)) is just some arbitrary point")
// 可以看到没有default也是通过编译的，但应该在default中包括所有的情况
}


/*
 * 6.9 Control Transfer（转移） Statements
 */

/*
four control transfer statements:
1.continue
2.break
3.fallthrough
4.return
 */

// Continue
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
for character in puzzleInput {
    switch character {
    case "a", "e", "i", "o", "u", " ":
        continue
    default:
        puzzleOutput += character
    }
}
puzzleOutput

// Fallthrough（跳进，通常指跳进switch语句中的下一个分支）
// The fallthrough keyword does not check the case conditions for the switch case that it causes execution to fall into. The fallthrough keyword simply causes code execution to move directly to the statements inside the next case (or default case) block, as in C’s standard switch statement behavior.
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
case 4, 6, 8:
    description += "not 4, 6, 8, "
    fallthrough // fallthrough只跳转一次
default:
    description += " an integer."
//    fallthrough // 不能在default语句中定义，否则报错
}
description


/*
 * 6.10 Lable Statements
 */

/*
形式如下：
label name: while condition {
    statements
}
 */
var sum = 0
sumLabel: while sum != 10 {
    if sum == 8 {
        break sumLabel
    }
    else if sum <= 7 {
        ++sum
        continue sumLabel
    }
    else {
        println("Sum")
    }
}
sum

// Using label name makes it clear which control statement should be terminated.（多层嵌套的时候，break指定的label名可以解决不知道break哪一个循环的问题）



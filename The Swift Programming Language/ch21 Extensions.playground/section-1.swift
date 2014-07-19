/*
 * 21.1 Extension Syntax
 */

/*
extension SomeType {
    // new functionality to add to SomeType goes here
}
 */

/*
An extension can extend an existing type to make it adopt one or more protocols. Where this is the case, the protocol names are written in exactly the same way as for a class or structure:

extension SomeType: SomeProtocol, AnotherProtocol {
    // implementation of protocol requirements goes here
}
 */


/*
 * 21.2 Computed Properties
 */

extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
let threeFeet = 3.ft
let aMarathon = 42.km + 195.m


/*
 * 21.3 Initializers
 */

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
    size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
    size: Size(width: 3.0, height: 3.0))


/*
 * 21.4 Methods
 */

extension Int {
    func repetitions(task: () -> ()) {
        for i in 0..<self {
            task()
        }
    }
}
3.repetitions({
println("Hello!")
})
// Hello!
// Hello!
// Hello!

3.repetitions {
    println("Goodbye!")
}
// Goodbye!
// Goodbye!
// Goodbye!


/*
 * 21.5 Mutating Instance Methods
 */

extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()
someInt


/*
 * 21.6 Subscripts
 */

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
            for _ in 1...digitIndex {
                decimalBase *= 10
            }
            return (self / decimalBase) % 10
    }
}
746381295[0]
746381295[1]
746381295[2]
746381295[8]
746381295[9]
0746381295[9]


/*
 * 21.6 Nested Types
 */

extension Character {
    enum Kind {
        case Vowel, Consonant, Other
    }
    var kind: Kind {
        switch String(self).lowercaseString {
            case "a", "e", "i", "o", "u":
                return .Vowel
            case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
    "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
                return .Consonant
            default:
                return .Other
            }
    }
}
func printLetterKinds(word: String) {
    println("'\(word)' is made up of the following kinds of letters:")
    for character in word {
        switch character.kind {
        case .Vowel:
            print("vowel ")
        case .Consonant:
            print("consonant ")
        case .Other:
            print("other ")
        }
    }
    print("\n")
}
printLetterKinds("Hello")
// 'Hello' is made up of the following kinds of letters:
// consonant vowel consonant consonant vowel
/*
NOTE:character.kind is already known to be of type Character.Kind. Because of this, all of the Character.Kind member values can be written in shorthand form inside the switch statement, such as .Vowel rather than Character.Kind.Vowel.
 */


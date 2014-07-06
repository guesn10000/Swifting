/*
 * 9.1 Enumeration Syntax
 */

// Swift enumeration members are not assigned a default integer value when they are created. In the CompassPoints example above, North, South, East and West do not implicitly equal 0, 1, 2 and 3.
enum CompassPoint {
    case North
    case South
    case East
    case West
}
var directionToHead = CompassPoint.South
directionToHead = .North // directionToHead的类型已经声明，因此可以用dot syntax让Swift自行推断其类型


/*
 * 9.2 Matching Enumeration Values with a Switch
 */

directionToHead = .South
switch directionToHead {
case .North:
    println("Lots of planets have a north")
case .South:
    println("Watch out for penguins")
case .East:
    println("Where the sun rises")
case .West:
    println("Where the skies are blue")
default:
    println("Not a safe place for humans")
}


/*
 * 9.3 Associated Values
 */

enum Barcode {
    case UPCA(Int, Int, Int)
    case QRCode(String)
}
var productBarcode = Barcode.UPCA(8, 85909_51226, 3)
productBarcode = .QRCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .UPCA(let numberSystem, let identifier, let check):
    numberSystem
    identifier
    check
case .QRCode(var productCode):
    productCode = "abcdefghijklmnop"
}

switch productBarcode {
case let .UPCA(numberSystem, identifier, check): // case后面的let指明了括号中的参数均为常数
    numberSystem
    identifier
    check
case var .QRCode(productCode):  // 同理
    productCode = "abcdefghijklmnop"
}


/*
 * 9.4 Raw Values
 */

// Raw values can be strings, characters, or any of the integer or floating-point number types. Each raw value must be unique within its enumeration declaration.
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

// When integers are used for raw values, they auto-increment if no value is specified for some of the enumeration members.
enum Planet: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
let earthsOrder = Planet.Earth.toRaw()
let possiblePlanet = Planet.fromRaw(7) // possiblePlanet is of type Planet? and equals Planet.Uranus
// the fromRaw method returns an optional enumeration member. In the example above, possiblePlanet is of type Planet?, or optional Planet.

let positionToFind = 9
if let somePlanet = Planet.fromRaw(positionToFind) {
    switch somePlanet {
    case .Earth:
        println("Mostly harmless")
    default:
        println("Not a safe place for humans")
    }
} else {
    println("There isn't a planet at position \(positionToFind)")
}


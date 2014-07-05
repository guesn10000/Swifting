
/*******************************************************************/

/*
 * 1.1 Simple Values
 */

// Variable
var myVariable = 42 // 类型默认为Integer
myVariable = 50
//var aVariable // 声明变量的同时要赋值，强制开发者为其赋初值

// Constant
let myConstant = 42
//myConstant = 50 // Error

// implicit or explicit type
let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70
let explicitFloat: Float = 4

// Values are never implicitly converted to another type
let shopItem = "Modem $"
let price = 10
//let itemPrice = shopItem + price // 不会进行隐式转换，报错
let itemPrice = shopItem + String(price)

// There’s an even simpler way to include values in strings: \(some values to convert)
let modemPrice = 65.0
let wifiPrice = 15.0
let Mr_John = "Mr.John"
let orderSummary = "Total price of the order is \(modemPrice) yuan, sir."
var orderSpecialSummary = "\(Mr_John), \(modemPrice + wifiPrice) yuan totoally."
orderSpecialSummary = Mr_John + ", \(modemPrice + wifiPrice) yuan please."

// arrays and dictionaries
var superstars = ["John Cena", "Roman Reigns", "Randy Orton", "Kane"]
superstars[0] = "Champ John Cena"
superstars
var championship = [
    "The Champ": superstars[0],
    "RR": superstars[1],
    "The Viper": superstars[2],
    "The big red monster": superstars[3]
]
championship["Unknow"] = "Brock Lesnar"
championship

// use the initializer syntax to create an empty array or dictionary
let emptyArray = String[]()
let emptyDictionary = Dictionary<String, Float>()
var inferredArray = [1, 2, 3]
inferredArray = [] // 清空数组
var inferredDictionary = [1:1, 2:2, 3:3] // 字典的key可以是整数等类型，而不只是String类型
inferredDictionary[1] = 10
inferredDictionary = [:] // 清空字典

/*
 * 1.2 Control Flow
 */

// 判断或循环条件中的括号可选，语句体中的大括号必需
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
//if(teamScore) // 错误，条件必须返回逻辑布尔值，但是teamScore不能隐式转换为teamScore与0比较的布尔值
if (teamScore > 0) { // 这样做使条件的目的性更强，增强可读性
    teamScore
}

// Write a question mark (?) after the type of a value to mark the value as optional
var optionalString: String? = "Hello"
optionalString == nil

// use if and let together to work with values that might be missing
var optionalName: String? = "John Appleseed"
optionalName = nil
var greeting = "Hello!"
if let name = optionalName { // 为常量name赋值，同时判断name == nil
    greeting = "Hello, \(name)"
}
else {
    greeting = "What's your name?"
}

// Switches support any kind of data and a wide variety of comparison operations—they aren’t limited to integers and tests for equality
let vegetable = "red pepper"
switch vegetable {
case "celery":
    let vegetableComment = "Add some raisins and make ants on a log."
case "cucumber", "watercress":
    let vegetableComment = "That would make a good tea sandwich."
case let x where x.hasSuffix("pepper"): // 这里的x和vegetable绑定在一起了
    let vegetableComment = "Is it a spicy \(x)?"
default: // default分支必须有，每个分支不需要break语句
    let vegetableComment = "Everything tastes good in soup."
}

// for-in循环遍历
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}
largest

// while循环
var n = 2
while n < 100 {
    n = n * 2
}
n

// do-while循环
var m = 2
do {
    m = m * 2
} while m < 100
m

// a..b表示[a, b)
var sum1 = 0
for i in 0..3 { // i不需要也不能用var声明
    sum1 += i
}
sum1
// 等价形式：
var sum2 = 0
for var i = 0; i < 3; ++i { // i必须用var声明
    sum2 += i
}
sum2

// a...b表示[a, b]
var sum3 = 0
for i in 0...3 {
    sum3 += i
}
sum3
// 等价形式：
var sum4 = 0
for var i = 0; i <= 3; ++i {
    sum4 += i
}
sum4


/*
 * 1.3 Functions and Closures
 */

// Use func to declare a function. Call a function by following its name with a list of arguments in parentheses. Use -> to separate the parameter names and types from the function’s return type.
func spear(attacker: String, defender: String) -> String {
    return "\(attacker) spear to \(defender)"
}
spear("Roman Reigns", "Kane")

// Use a tuple to return multiple values from a function.
func getTheSheild() -> (String, String, String) {
    return ("Dean Ambrose", "Seth Rollins", "Roman Reigns")
}
let Sheild = getTheSheild()
let DeanAmbrose = Sheild.0
let SethRollins = Sheild.1
let RomanReigns = Sheild.2
//let hello = Sheild.3 // Error

// a variable number of arguments, which is collecting into an array.
func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
sumOf()
sumOf(1)
sumOf(1, 2, 3)
sumOf(1, 3, 5, 7, 9)

// Functions can be nested
func complexSpear() -> String {
    var s: String = ""
    func supermanTouch() {
        s += "Superman Touch"
    }
    supermanTouch()
    s += " and Spear"
    return s
}
complexSpear()

// a function can return another function as its value.
func attitudeAdjustment() -> (Bool -> String) {
    func AA(isJohnCena: Bool) -> String {
        if isJohnCena {
            return "AA from John Cena"
        }
        else {
            return "No AA"
        }
    }
    return AA // 返回的是函数，(Bool -> String)是返回的函数自身的返回类型
}
var AAVar = attitudeAdjustment() // 注意这里的var AAVar是一个function类型的变量
AAVar(true)
AAVar(false)

// A function can take another function as one of its arguments.
func canUseAA(list: String[], isJohnCena: String -> Bool) -> (String, Bool) {
    for superStar in list {
        if isJohnCena(superStar) {
            return (superStar, true)
        }
    }
    return ("You are not John Cena", false)
}
func isJohnCena(name: String) -> Bool {
    if name == "John Cena" {
        return true
    }
    else {
        return false
    }
}
var johnCenas = ["John Cena", "JohnCena", "John Cenation"]
canUseAA(johnCenas, isJohnCena)

// Functions are actually a special case of closures. You can write a closure without a name by surrounding code with braces ({}). Use in to separate the arguments and return type from the body.
canUseAA(johnCenas, {
    (name: String) -> Bool in
    if (name == "John Cena") {
        return true
    }
    else {
        return false
    }
    })

// refer to parameters by number instead of by name—this approach is especially useful in very short closures.
sort([1, 3, 2, 4, 0, 6, 5, 9, 8, 7]) {
    $0 < $1
}


/*
 * 1.4 Objects and Classes
 */

// a class
class SuperStar {
    // Every property needs a value assigned—either in its declaration (as with numberOfSides) or in the initializer (as with name).
    var name: String // 类中的成员可以先不用赋值，因为在init方法中将被初始化，否则编译器会报错
    var championTimes = 0
    let CHAMPION = "champion"
    
    // an initializer to set up the class when an instance is created. Use init to create one.
    init(starName: String) {
        self.name = starName
    }
    
    func championDescription() -> String {
        return "\(championTimes) times \(CHAMPION) -- \(name)"
    }
    
    // Use deinit to create a deinitializer if you need to perform some cleanup before the object is deallocated.
}

// Create an instance of a class by putting parentheses after the class name. Use dot syntax to access the properties and methods of the instance.
var JohnCena_SuperStar = SuperStar(starName: "John Cena") // 初始化时参数列表中必须声明参数名
JohnCena_SuperStar.championTimes = 15
var champDescription = JohnCena_SuperStar.championDescription()

// subclass
class WWESuperStar: SuperStar {
    var weight: Float // 如果初始化时不赋初值，就必须声明其类型
    let WWECHAMPION = "WWE Champion"
    
    /*
    init方法中的三部曲
    Notice that the initializer for the EquilateralTriangle class has three different steps:
    
    1.Setting the value of properties that the subclass declares.
    2.Calling the superclass’s initializer.
    3.Changing the value of properties defined by the superclass. Any additional setup work that uses methods, getters, or setters can also be done at this point.
    */
    init(name: String, weight: Float) {
        self.weight = weight // 必须先初始化类的属性，再调用父类的init方法
        super.init(starName: name)
        championTimes = 15 // 在调用父类的init方法后，就可以使用其属性了
    }
    
    // In addition to simple properties that are stored, properties can have a getter and a setter.
    var weight_kg: Float { // 有getter/setter方法的变量必须显式声明其类型
    get {
        return weight / 1.2
    }
    set {
        weight = newValue * 1.2
    }
    }
    
    override func championDescription() -> String { // 重写父类的方法时必须要加override修饰
        return "\(name), \(weight) pounds, \(championTimes) times \(WWECHAMPION)"
    }
}
var JohnCena_WWEStar = WWESuperStar(name: "John Cena", weight: 270)
var wwechampDescription = JohnCena_WWEStar.championDescription()

// set和get weight_kg的值，看看weight的变化
JohnCena_WWEStar.weight_kg
JohnCena_WWEStar.weight
JohnCena_WWEStar.weight_kg = 230
JohnCena_WWEStar.weight_kg
JohnCena_WWEStar.weight

// will set and did set
class TNASuperStar {
    var weight: Float = 0
    
    init(weight: Float) {
        self.weight = weight
    }
}
class Stars {
    var wweStar: WWESuperStar
    
    var tnaStar: TNASuperStar {
    willSet {
        wweStar.weight = newValue.weight
    }
    }
    
    init() {
        wweStar = WWESuperStar(name: "John Cena", weight: -1)
        tnaStar = TNASuperStar(weight: 200)
    }
}
var aStar = Stars()
aStar.wweStar.weight
aStar.tnaStar = TNASuperStar(weight: 200)
aStar.wweStar.weight

// 调用函数的参数形式
class Counter {
    var count: Int = 0
    func incrementBy(amount: Int, numberOfTimes times: Int) { // numberOfTime和times指同一个参数，只是名字不同
        count += amount * times
    }
}
var counter = Counter()
counter.incrementBy(2, numberOfTimes: 7) // 第一个参数名可以忽略，剩余的参数名是必须的

// When working with optional values, you can write ? before operations like methods, properties, and subscripting. If the value before the ? is nil, everything after the ? is ignored and the value of the whole expression is nil. Otherwise, the optional value is unwrapped, and everything after the ? acts on the unwrapped value. In both cases, the value of the whole expression is an optional value.
var optionalCounter: Counter? = Counter()
optionalCounter = nil
let count = optionalCounter?.count


/*
 * 1.5 Enumerations and Structures
 */

// 定义枚举
// In the example above, the raw value type of the enumeration is Int, so you only have to specify the first raw value. The rest of the raw values are assigned in order.
enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDescription() -> String {
        switch self {
        case .Ace: // 由于已经明确是枚举类型，所以可以通过.Ace的写法来引用枚举中的值
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.toRaw())
        }
    }
}

// toRaw函数和调用枚举中的方法
let ace = Rank.Ace
let aceRawValue = ace.toRaw()
ace.simpleDescription()
let two = Rank.Two
let twoRawValue = two.toRaw()
two.simpleDescription()
let three = Rank.Three
let threeRawValue = three.toRaw()
three.simpleDescription()
let nine = Rank.Nine
let nineRawValue = nine.toRaw()
nine.simpleDescription()
let jack = Rank.Jack
let jackRawValue = jack.toRaw()
jack.simpleDescription()
let queen = Rank.Queen
let queenRawValue = queen.toRaw()
queen.simpleDescription()
let king = Rank.King
let kingRaw = king.toRaw()
king.simpleDescription()

// 比较两个枚举值的函数
func compareRankValues(rankValue1: Rank, rankValue2: Rank) -> String {
    if rankValue1.toRaw() > rankValue2.toRaw() {
        return rankValue1.simpleDescription() + " > " + rankValue2.simpleDescription()
    }
    else if rankValue1.toRaw() == rankValue2.toRaw() {
        return rankValue1.simpleDescription() + " = " + rankValue2.simpleDescription()
    }
    else {
        return rankValue1.simpleDescription() + " < " + rankValue2.simpleDescription()
    }
}
compareRankValues(Rank.Ace, Rank.Jack)
compareRankValues(Rank.King, Rank.King)

// fromRaw函数
// The member values of an enumeration are actual values, not just another way of writing their raw values.
if let convertedRank = Rank.fromRaw(3) {
    let threeDescription = convertedRank.simpleDescription()
}

// structures and classes is that structures are always copied when they are passed around in your code, but classes are passed by reference.
struct Card {
    var rank: Rank
    var rankValue: Int
    func simpleDescription() -> String {
        return "The value of card \(rank.simpleDescription()) is \(rankValue)"
    }
}
let threeOfSpades = Card(rank: .Jack, rankValue: 11)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()

// an enumeration member can have values associated with the instance.
enum ServerResponse {
    case Result(String, String)
    case Error(String)
}
let success = ServerResponse.Result("6:00 am", "8:09 pm")
let failure = ServerResponse.Error("Out of cheese.")
switch success {
case let .Result(sunrise, sunset): // let必不可少
    let serverResponse = "Sunrise is at \(sunrise) and sunset is at \(sunset)."
case let .Error(error):
    let serverResponse = "Failure...  \(error)"
}


/*
 * 1.6 Protocols and Extensions
 */

// declare a protocol.
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

// Classes adopt protocols.
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() { // The declaration of SimpleClass doesn’t need any of its methods marked as mutating because methods on a class can always modify the class.
        simpleDescription += "  Now 100% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

// structs adopt protocols.
struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() { // the mutating keyword mark a method that modifies the structure.
        simpleDescription += " (adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription

// EXPERIMENT:Write an enumeration that conforms to this protocol.
// ?

// Use extension to add functionality to an existing type
extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}
7.simpleDescription


/*
 * 1.7 Generics 泛型
 */

// make a generic function or type.
func repeat<ItemType>(item: ItemType, times: Int) -> ItemType[] {
    var result = ItemType[]()
    for i in 0..times {
        result += item
    }
    return result
}
repeat("knock", 4)

// Reimplement the Swift standard library's optional type
enum OptionalValue<T> {
    case None
    case Some(T)
}
var possibleInteger: OptionalValue<Int> = .None
possibleInteger = .Some(100)

// Use where after the type name to specify a list of requirements
func anyCommonElements <T, U where T: Sequence, U: Sequence, T.GeneratorType.Element: Equatable, T.GeneratorType.Element == U.GeneratorType.Element> (lhs: T, rhs: U) -> Bool {
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    return false
}
anyCommonElements([1, 2, 3], [3])


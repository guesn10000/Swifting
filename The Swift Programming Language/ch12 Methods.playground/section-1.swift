/*
 * 12.1 Instance Methods
 */
class Counter {
    var count = 0
    func increment() {
        count++
    }
    func incrementBy(amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
let counter = Counter()
counter.increment()
counter.incrementBy(5)
counter.reset()


/*
 * 12.2 Local and External Parameter Names for Methods
 */

class Counter_paramName {
    var count: Int = 0
    func incrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
}
let counter_p = Counter_paramName()
counter_p.incrementBy(5, numberOfTimes: 3)
//counter_p.incrementBy(5, 3) // 报错：第二个参数前必须带有external参数名
//counter_p.incrementBy(amount: 5, numberOfTimes: 3) // 报错：第一个参数不需要声明参数名
/*
上面的类定义等价于：
func incrementBy(amount: Int, #numberOfTimes: Int) {
    count += amount * numberOfTimes
}
 */
// Conversely（相反地）, if you do not want to provide an external name for the second or subsequent parameter of a method, override the default behavior by using an underscore character (_) as an explicit external parameter name for that parameter.


/*
 * 12.3 The self Property
 */

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x // 用self来区分对象属性x和函数的参数x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
somePoint.isToTheRightOfX(1.0)


/*
 * 12.4 Modifying Value Types from Within Instance Methods
 */

// “Structures and enumerations are value types. By default, the properties of a value type cannot be modified from within its instance methods. If you need to modify the properties of your structure or enumeration within a particular method, you can opt（选择） in to mutating behavior for that method.
struct Point_mutating {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint_mutating = Point_mutating(x: 1.0, y: 1.0)
somePoint_mutating.moveByX(2.0, y: 3.0)

// you cannot call a mutating method on a constant of structure type, because its properties cannot be changed
let fixedPoint = Point_mutating(x: 3.0, y: 3.0)
//fixedPoint.moveByX(2.0, y: 3.0) // 报错


/*
 * 12.5 Assigning to self Within a Mutating Method
 */

struct Point_selfAssign {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        self = Point_selfAssign(x: x + deltaX, y: y + deltaY)
    }
}
var somePoint_selfAssign = Point_selfAssign()
somePoint_selfAssign.moveByX(10.0, y: 20.0)
somePoint_selfAssign

// Mutating methods for enumerations can set the implicit self parameter to be a different member from the same enumeration
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()
ovenLight == .High
ovenLight.next()
ovenLight == .Off


/*
 * 12.6 Type Methods
 */

// In Swift, you can define type-level methods for all classes, structures, and enumerations. You indicate type methods for classes by writing the keyword class before the method’s func keyword, and type methods for structures and enumerations by writing the keyword static before the method’s func keyword.
class SomeClass {
    class func someTypeMethod() {
        // type method implementation goes here
    }
}
SomeClass.someTypeMethod()

struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    static func levelIsUnlocked(level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    var currentLevel = 1
    mutating func advanceToLevel(level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}
class Player {
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    init(name: String) {
        playerName = name
    }
}
var player = Player(name: "Argyrios")
player.completedLevel(1)
LevelTracker.highestUnlockedLevel
player = Player(name: "Beto")
if player.tracker.advanceToLevel(6) {
    var string = "player is now on level 6"
} else {
    var string = "level 6 has not yet been unlocked"
}
var lt = LevelTracker()
//lt.unlockLevel(1) // 报错，不能用instance来调用type methods


/*
 * 11.1 Stored Properties
 */

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//rangeOfFourItems.firstValue = 6 // Error，因为rangeOfFourItems是常数


/*
 * 11.2 Lazy Stored Properties
 */

// A lazy stored property is a property whose initial value is not calculated until the first time it is used. You indicate a lazy stored property by writing the @lazy attribute before its declaration.
// You must always declare a lazy property as a variable (with the var keyword), because its initial value may not be retrieved until after instance initialization completes. Constant properties must always have a value before initialization completes, and therefore cannot be declared as lazy.

class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a non-trivial amount of time to initialize.
    */
    var fileName = "data.txt"
    // the DataImporter class would provide data importing functionality here
}
class DataManager {
    @lazy var importer = DataImporter()
    var data = String[]()
    // the DataManager class would provide data management functionality here
}
let manager = DataManager()
manager.data += "Some data"
manager.data += "Some more data"
// the DataImporter instance for the importer property has not yet been created

// Because it is marked with the @lazy attribute, the DataImporter instance for the importer property is only created when the importer property is first accessed, such as when its fileName property is queried:
manager.importer.fileName

/*
Stored Properties and Instance Variables:
If you have experience with Objective-C, you may know that it provides two ways to store values and references as part of a class instance. In addition to properties, you can use instance variables as a backing store for the values stored in a property.

Swift unifies（统一） these concepts into a single property declaration. A Swift property does not have a corresponding（相联系的） instance variable, and the backing store for a property is not accessed directly. This approach avoids confusion about how the value is accessed in different contexts and simplifies the property’s declaration into a single, definitive statement. All information about the property—including its name, type, and memory management characteristics—is defined in a single location as part of the type’s definition.
 */


/*
 * 11.3 Computed Properties
 */

// enumerations can define computed properties, which do not actually store a value. Instead, they provide a getter and an optional setter to retrieve and set other properties and values indirectly.
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
    get {
        let centerX = origin.x + (size.width / 2)
        let centerY = origin.y + (size.height / 2)
        return Point(x: centerX, y: centerY)
    }
    set(newCenter) {
        origin.x = newCenter.x - (size.width / 2)
        origin.y = newCenter.y - (size.height / 2)
    }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
    size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
square.origin

// Shorthand Setter Declaration: if a computed property’s setter does not define a name for the new value to be set, a default name of "newValue" is used.
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
    get {
        let centerX = origin.x + (size.width / 2)
        let centerY = origin.y + (size.height / 2)
        return Point(x: centerX, y: centerY)
    }
    set { // 相当于set(newValue)
        origin.x = newValue.x - (size.width / 2)
        origin.y = newValue.y - (size.height / 2)
    }
    }
}

// Read-Only Computed Properties: a computed property with a getter but no setter is known as a read-only computed property.
// You must declare computed properties—including read-only computed properties—as variable properties with the var keyword, because their value is not fixed.
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
    return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
//fourByFiveByTwo.volume = 10.0 // 会造成playground崩溃
fourByFiveByTwo.volume // it is useful for a Cuboid to provide a read-only computed property to enable external users to discover its current calculated volume.


/*
 * 11.4 Property Observers
 */

// Property observers observe and respond to changes in a property’s value. Property observers are called every time a property’s value is set, even if the new value is the same as the property’s current value.
// You can add property observers to any stored properties you define, apart from（除了） lazy stored properties. You can also add property observers to any inherited property (whether stored or computed) by overriding the property within a subclass.

/*
You have the option to define either or both of these observers on a property:
1.willSet is called just before the value is stored.
2.didSet is called immediately after the new value is stored.
 */

// willSet and didSet observers are not called when a property is first initialized. They are only called when the property’s value is set outside of an initialization context.

class StepCounter {
    var totalSteps: Int = 0 {
    willSet { // 相当于willSet(newValue)
        println("About to set totalSteps to \(newValue)")
    }
    didSet { // newValue和oldValue是默认的
        if totalSteps > oldValue  {
            totalSteps += 10 // If you assign a value to a property within its own didSet observer, the new value that you assign will replace the one that was just set. 并且不会触发新的willSet和didSet方法被调用。
            println("Added \(totalSteps - oldValue) steps")
        }
    }
    }
}
let stepCounter = StepCounter() // 初始化的时候属性观察者不起作用
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896


/*
 * 11.5 Global and Local Variables
 */

// Global variables are variables that are defined outside of any function, method, closure, or type context. Local variables are variables that are defined within a function, method, or closure context.

// Global constants and variables are always computed lazily, in a similar manner to Lazy Stored Properties. Unlike lazy stored properties, global constants and variables do not need to be marked with the @lazy attribute. Local constants and variables are never computed lazily.


/*
 * 11.6 Type Properties
 */

// Type properties are useful for defining values that are universal to all instances of a particular type, such as a constant property that all instances can use (like a static constant in C), or a variable property that stores a value that is global to all instances of that type (like a static variable in C).

// You define type properties for value types with the static keyword, and type properties for class types with the class keyword.
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 0
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 0
    }
}
class SomeClass {
    class var computedTypeProperty: Int {
        return 0
    }
}
SomeClass.computedTypeProperty
SomeStructure.storedTypeProperty
SomeStructure.storedTypeProperty = "Another value."
SomeStructure.storedTypeProperty
var someInstance = SomeClass()
//someInstance.computedTypeProperty // 错误，不能用instance来调用type properties

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
    didSet {
        if currentLevel > AudioChannel.thresholdLevel {
            currentLevel = AudioChannel.thresholdLevel
        }
        if currentLevel > AudioChannel.maxInputLevelForAllChannels {
            AudioChannel.maxInputLevelForAllChannels = currentLevel
        }
    }
    }
}
var leftChannel = AudioChannel()
var rightChannel = AudioChannel()
leftChannel.currentLevel = 7
leftChannel.currentLevel
AudioChannel.maxInputLevelForAllChannels
leftChannel.currentLevel = 11
leftChannel.currentLevel
AudioChannel.maxInputLevelForAllChannels


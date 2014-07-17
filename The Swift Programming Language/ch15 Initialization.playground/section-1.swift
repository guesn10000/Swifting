/*
 * 15.1 Preview
 */

/*
Unlike Objective-C initializers, Swift initializers do not return a value. Their primary role is to ensure that new instances of a type are correctly initialized before they are used for the first time.
 */

/*
Classes and structures must set all of their stored properties to an appropriate initial value by the time an instance of that class or structure is created. Stored properties cannot be left in an indeterminate state.

You can set an initial value for a stored property within an initializer, or by assigning a default property value as part of the property’s definition.

When you assign a default value to a stored property, or set its initial value within an initializer, the value of that property is set directly, without calling any property observers.
 */


/*
 * 15.2 Initializers
 */

// Simplest form of initializer
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
f.temperature

/*
Alternatively, specify a default property value as part of the property’s declaration. You specify a default property value by assigning an initial value to the property when it is defined.

If a property always takes the same initial value, provide a default value rather than setting a value within an initializer.
 */
struct Fahrenheit_defaultValue {
    var temperature = 32.0
}
var f_dv = Fahrenheit_defaultValue()
f_dv.temperature


/*
 * 15.3 Customizing Initialization
 */

// Initialization Parameters
struct Celsius {
    var temperatureInCelsius: Double = 0.0
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
boilingPointOfWater.temperatureInCelsius
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
freezingPointOfWater.temperatureInCelsius

/*
Local and External Parameter Names

the names and types of an initializer’s parameters play a particularly important role in identifying which initializer should be called. Because of this, Swift provides an automatic external name for every parameter in an initializer if you don’t provide an external name yourself. This automatic external name is the same as the local name.

If you do not want to provide an external name for a parameter in an initializer, provide an underscore (_) as an explicit external name for that parameter to override the default behavior described above.
 */
struct Color {
    let red = 0.0, green = 0.0, blue = 0.0
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
}
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
//let veryGreen = Color(0.0, 1.0, 0.0) // this reports a compile-time error - external names are required


/*
 * 15.4 Optional Property Types
 */
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        println(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?") // optional String is automatically assigned a default value of nil
cheeseQuestion.ask()


/*
 * 15.5 Modifying Constant Properties During Initialization
 */

// You can modify the value of a constant property at any point during initialization, as long as it is set to a definite value by the time initialization finishes.

// For class instances, a constant property can only be modified during initialization by the class that introduces it. It cannot be modified by a subclass.

class SurveyQuestion_constant {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        println(text)
    }
}
let beetsQuestion = SurveyQuestion_constant(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.response = "I also like beets. (But not with cheese.)"


/*
 * 15.6 Default Initializers
 */

// Swift provides a default initializer for any structure or base class that provides default values for all of its properties and does not provide at least one initializer itself. The default initializer simply creates a new instance with all of its properties set to their default values.
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()


/*
 * 15,7 Memberwise Initializers for Structure Types
 */

// Structure types automatically receive a memberwise initializer if they do not define any of their own custom initializers.
// The memberwise initializer is a shorthand way to initialize the member properties of new structure instances. Initial values for the properties of the new instance can be passed to the memberwise initializer by name.
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)
//let threeByThree = Size(3.0, 3.0) // Error
//let threeByThree = Size(height: 3.0, width: 3.0) // Error


/*
 * 15.8 Initializer Delegation（委托） for Value Types
 */

// Initializers can call other initializers to perform part of an instance’s initialization. This process, known as initializer delegation, avoids duplicating code across multiple initializers.
// The rules for how initializer delegation works, and for what forms of delegation are allowed, are different for value types and class types. Value types (structures and enumerations) do not support inheritance, and so their initializer delegation process is relatively simple, because they can only delegate to another initializer that they provide themselves. Classes, however, can inherit from other classes, as described in Inheritance. This means that classes have additional responsibilities for ensuring that all stored properties they inherit are assigned a suitable value during initialization.

// For value types, you use self.init to refer to other initializers from the same value type when writing your own custom initializers. You can only call self.init from within an initializer.
struct Size_rect {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size_rect()
    init() {}
    init(origin: Point, size: Size_rect) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size_rect) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let basicRect = Rect()
let originRect = Rect(
    origin: Point(x: 2.0, y: 2.0),
    size: Size_rect(width: 5.0, height: 5.0)
)
let centerRect = Rect(
    center: Point(x: 4.0, y: 4.0),
    size: Size_rect(width: 3.0, height: 3.0)
)

// For an alternative way to write this example without defining the init() and init(origin:size:) initializers yourself, see Extensions.


/*
 * 15.9 Class Inheritance and Initialization
 */

// “All of a class’s stored properties—including any properties the class inherits from its superclass—must be assigned an initial value during initialization.
// Swift defines two kinds of initializers for class types to help ensure all stored properties receive an initial value. These are known as designated initializers and convenience initializers.


/*
 * 15.10 Designated Initializers and Convenience Initializers
 */

// Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.

// Convenience initializers are secondary, supporting initializers for a class. You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values. You can also define a convenience initializer to create an instance of that class for a specific use case or input value type.


/*
 * 15.11 Initializer Chaining
 */

/*
To simplify the relationships between designated and convenience initializers, Swift applies the following three rules for delegation calls between initializers:

Rule 1
    Designated initializers must call a designated initializer from their immediate superclass.

Rule 2
    Convenience initializers must call another initializer available in the same class.

Rule 3
    Convenience initializers must ultimately end up calling a designated initializer.

A simple way to remember this is:
1.Designated initializers must always delegate up.
2.Convenience initializers must always delegate across.

1.Designated initializers和Convenience initializers关系图见Initializer Chaining中的图
2.四个带继承关系的类图种Designated initializers和Convenience initializers关系图见Initializer Chaining中的图
简单来说，就是：
同一个类中的Convenience initializers必须调用Designated Initializers
子类的一个或多个Designated Initializers都必须调用父类中的Designated Initializers
 */


/*
* 15.12 Two-Phase Initialization, Initializer Inheritance and Overriding, Automatic Initializer Inheritance
 */

/* 详见中文版 */


/*
 * 15.13 Syntax for Designated and Convenience Initializers
 */

/*
Designated initializers syntax:
init(parameters) {
    statements
}

Convenience initializers syntax:
convenience init(parameters) {
    statements
}
 */

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
/*
注意,RecipeIngredient 的便利构造器 init(name: String)使用了跟 Food 中指定构造器 init(name: String)相同的参数。尽管 RecipeIngredient 这个构造器是便利构造器, RecipeIngredient 依然提供了对所有父类指定构造器的实现。因此,RecipeIngredient 也能自动继承了所有父类的便利构造器。 在这个例子中,RecipeIngredient 的父类是 Food,它有一个便利构造器 init()。这个构造器因此也被 RecipeIngredient 继承。这个继承的 init()函数版本跟 Food 提供的版本是一样 的,除了它是将任务代理给 RecipeIngredient 版本的 init(name: String)而不是 Food 提供 的版本。
 */

class ShoppingListItem_InherInit: RecipeIngredient {
    var purchased = false;
    var description: String {
        var output = "\(quantity) * \(name.lowercaseString)"
        output += purchased ? "√" : "×"
        return output
    }
}
// ShoppingListItem automatically inherits all of the designated and convenience initializers from its superclass.

// 三个类的继承关系和初始化链见原书
var breakfastList = [
    ShoppingListItem_InherInit(),
    ShoppingListItem_InherInit(name: "Bacon"),
    ShoppingListItem_InherInit(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    println(item.description)
}


/*
 * 15.14 Setting a Default Property Value with a Closure or Function
 */

/*
If a stored property’s default value requires some customization or setup, you can use a closure or global function to provide a customized default value for that property. Whenever a new instance of the type that the property belongs to is initialized, the closure or function is called, and its return value is assigned as the property’s default value.

These kinds of closures or functions typically create a temporary value of the same type as the property, tailor that value to represent the desired initial state, and then return that temporary value to be used as the property’s default value.
 */

/*
大致语法
class SomeClass {
    let someProperty: SomeType = {
        // create a default value for someProperty inside this closure
        // someValue must be of the same type as SomeType
        return someValue
        }()
}

注意后面的两个括号：Note that the closure’s end curly brace is followed by an empty pair of parentheses. This tells Swift to execute the closure immediately. If you omit these parentheses, you are trying to assign the closure itself to the property, and not the return value of the closure.
 */

// If you use a closure to initialize a property, remember that the rest of the instance has not yet been initialized at the point that the closure is executed. This means that you cannot access any other property values from within your closure, even if those properties have default values. You also cannot use the implicit self property, or call any of the instance’s methods.

struct Checkerboard {
    let boardColors: Bool[] = {
        var temporaryBoard = Bool[]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
        }()
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 10) + column]
    }
}
let board = Checkerboard()
println(board.squareIsBlackAtRow(0, column: 1))
println(board.squareIsBlackAtRow(9, column: 9))


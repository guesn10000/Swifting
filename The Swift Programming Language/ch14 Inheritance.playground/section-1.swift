/*
 * 14.1 Defining a Base Class
 */

// Any class that does not inherit from another class is known as a base class.
// Swift classes do not inherit from a universal base class. Classes you define without specifying a superclass automatically become base classes for you to build upon.（OC中所有类都继承自NSObject类，而Swift没有这样的规定）

class Vehicle {
    var numberOfWheels: Int
    var maxPassengers: Int
    func description() -> String {
        return "\(numberOfWheels) wheels; up to \(maxPassengers) passengers"
    }
    init() {
        numberOfWheels = 0
        maxPassengers = 1
    }
}
let someVehicle = Vehicle()
someVehicle.description()


/*
 * 14.2 Subclassing
 */

class Bicycle: Vehicle {
    init() { // Unlike Objective-C, initializers are not inherited by default in Swift.
        super.init() // super.init(), the initializer for the Bicycle class’s superclass, Vehicle, and ensures that all of the inherited properties are initialized by Vehicle before Bicycle tries to modify them.
        numberOfWheels = 2
    }
}

// As well as inheriting the properties of Vehicle, Bicycle also inherits its methods.
let bicycle = Bicycle()
bicycle.description()

// Subclasses can themselves be subclassed:
class Tandem: Bicycle {
    init() {
        super.init()
        maxPassengers = 2
    }
}
let tandem = Tandem()
tandem.description()

// Subclasses are only allowed to modify variable properties of superclasses during initialization. You can’t modify inherited constant properties of subclasses.


/*
 * 14.3 Overriding
 */

// A subclass can provide its own custom implementation of an instance method, class method, instance property, or subscript that it would otherwise inherit from a superclass. This is known as overriding.
// To override a characteristic that would otherwise be inherited, you prefix your overriding definition with the override keyword. Doing so clarifies that you intend to provide an override and have not provided a matching definition by mistake. Overriding by accident can cause unexpected behavior, and any overrides without the override keyword are diagnosed（诊断） as an error when your code is compiled.
// The override keyword also prompts the Swift compiler to check that your overriding class’s superclass (or one of its parents) has a declaration that matches the one you provided for the override. This check ensures that your overriding definition is correct.

/*
Accessing Superclass Methods, Properties, and Subscripts
1.Method:    super.someMethod()
2.Property:  super.someProperty
3.Subscript: super[someIndex]
 */


/*
 * 14.4 Overriding Methods
 */

class Car: Vehicle {
    var speed: Double = 0.0
    init() {
        super.init()
        maxPassengers = 5
        numberOfWheels = 4
    }
    override func description() -> String {
        return super.description() + "; "
            + "traveling at \(speed) mph"
    }
}
let car = Car()
car.description()


/*
 * 14.5 Overriding Properties
 */

// Overriding Properties: You can override an inherited instance or class property to provide your own custom getter and setter for that property, or to add property observers to enable the overriding property to observe when the underlying property value changes.


/*
 * 14.6 Overriding Property Getters and Setters
 */

// You can present an inherited read-only property as a read-write property by providing both a getter and a setter in your subclass property override. You cannot, however, present an inherited read-write property as a read-only property.
// If you provide a setter as part of a property override, you must also provide a getter for that override. If you don’t want to modify the inherited property’s value within the overriding getter, you can simply pass through the inherited value by returning super.someProperty from the getter
class SpeedLimitedCar: Car {
    override var speed: Double  {
    get {
        return super.speed
    }
    set {
        super.speed = min(newValue, 40.0)
    }
    }
}
let limitedCar = SpeedLimitedCar()
limitedCar.speed = 60.0
limitedCar.description()


/*
 * 14.7 Overriding Property Observers
 */

// You can use property overriding to add property observers to an inherited property. This enables you to be notified when the value of the inherited property changes, regardless of how that property was originally implemented.

// You cannot add property observers to inherited constant stored properties or inherited read-only computed properties. The value of these properties cannot be set, and so it is not appropriate to provide a willSet or didSet implementation as part of an override.

// You cannot provide both an overriding setter and an overriding property observer（不能同时重写setter方法和property观察者方法）. If you want to observe changes to a property’s value, and you are already providing a custom setter for that property, you can simply observe any value changes from within the custom setter.

class AutomaticCar: Car {
    var gear = 1
    override var speed: Double {
    didSet {
        gear = Int(speed / 10.0) + 1
    }
    }
    override func description() -> String {
        return super.description() + " in gear \(gear)"
    }
}

let automatic = AutomaticCar()
automatic.speed = 35.0
automatic.description()


/*
 * 14.8 Preventing Overrides
 */

// You can prevent a method, property, or subscript from being overridden by marking it as final. Do this by writing the @final attribute before its introducer keyword (such as @final var, @final func, @final class func, and @final subscript).

// Any attempts to override a final method, property, or subscript in a subclass are reported as a compile-time error. Methods, properties or subscripts that you add to a class in an extension can also be marked as final within the extension’s definition.

// You can mark an entire class as final by writing the @final attribute before the class keyword in its class definition (@final class). Any attempts to subclass a final class will be reported as a compile-time error.


/*
 * 14.9 No multiple inheritance
 */

class A1 {
    
}

class A2 {
    
}

//class B1: A1, A2 { // Error: multiple inheritance
//    
//}

class B2: A1 {
    
}
class B3: A1 {
    
}

// 总结：不允许一个类同时继承多个父类，一个父类可以有多个子类


/*
 * 17.1 ARC in Action
 */

class APerson {
    let name: String
    init(name: String) {
        self.name = name
        println("\(name) is being initialized")
    }
    deinit {
        println("\(name) is being deinitialized")
    }
}
var reference1: APerson?
var reference2: APerson?
var reference3: APerson?
reference1 = APerson(name: "John Appleseed")
reference2 = reference1
reference3 = reference1
reference1 = nil
reference2 = nil
reference3 = nil


/*
 * 17.2 Strong Reference Cycles Between Class Instances
 */

class SPerson {
    let name: String
    init(name: String) { self.name = name }
    var apartment: SApartment?
    deinit {
        println("\(name) is being deinitialized")
    }
}

class SApartment {
    let number: Int
    init(number: Int) { self.number = number }
    var tenant: SPerson?
    deinit {
        println("Apartment #\(number) is being deinitialized")
    }
}

var sjohn: SPerson?
var snumber73: SApartment?

sjohn = SPerson(name: "John Appleseed")
snumber73 = SApartment(number: 73)

sjohn!.apartment = snumber73
snumber73!.tenant = sjohn

sjohn = nil
snumber73 = nil
// 形成强引用环，内存泄露


/*
 * 17.3 Resolving Strong Reference Cycles Between Class Instances
 */

// 方法一：Weak References
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { println("\(name) is being deinitialized") }
}

class Apartment {
    let number: Int
    init(number: Int) { self.number = number }
    weak var tenant: Person? // weak声明
    deinit { println("Apartment #\(number) is being deinitialized") }
}

var john: Person?
var number73: Apartment?

john = Person(name: "John Appleseed")
number73 = Apartment(number: 73)

john!.apartment = number73
number73!.tenant = john

john = nil
number73 = nil
// 解决强引用环的问题，内存不会泄露

// 方法二：Unowned References
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { println("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer // unowned声明
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { println("Card #\(number) is being deinitialized") }
}

var john1: Customer?
john1 = Customer(name: "John Appleseed")
john1!.card = CreditCard(number: 1234_5678_9012_3456, customer: john1!)
john = nil
// 解决强引用环的问题，内存不会泄露


/*
 * 17.4 Unowned References and Implicitly Unwrapped Optional Properties
 */

class Country {
    let name: String
    let capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

var country = Country(name: "Canada", capitalName: "Ottawa")
println("\(country.name)'s capital city is called \(country.capitalCity.name)")


/*
 * 17.5 Strong Reference Cycles for Closures
 */

class HTMLElement {
    let name: String
    let text: String?
    
    @lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        println("\(name) is being deinitialized")
    }
    
}

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
println(paragraph!.asHTML())
paragraph = nil
// 形成强引用环，内存泄露


/*
 * 17.6 Resolving Strong Reference Cycles for Closures
 */

// 解决方法：Defining a Capture List

/*
@lazy var someClosure: (Int, String) -> String = {
    [unowned self] (index: Int, stringToProcess: String) -> String in
    // closure body goes here
}
 */

// 参数列表为空的情况
/*
@lazy var someClosure: () -> String = {
    [unowned self] in
    // closure body goes here
}
 */


/*
 * 17.7 Weak and Unowned References
 */

class UHTMLElement {
    let name: String
    let text: String?
    
    @lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        println("\(name) is being deinitialized")
    }
}

var uparagraph: UHTMLElement? = UHTMLElement(name: "p", text: "hello, world")
println(uparagraph!.asHTML())
// 解决强引用环的问题，内存不会泄露


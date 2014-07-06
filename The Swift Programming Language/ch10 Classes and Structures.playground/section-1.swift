/*
 * 10.1 Comparing Classes and Structures
 */

/*
Classes have additional capabilities that structures do not:
1.Inheritance enables one class to inherit the characteristics of another.
2.Type casting enables you to check and interpret the type of a class instance at runtime.
3.Deinitializers enable an instance of a class to free up any resources it has assigned.
4.Reference counting allows more than one reference to a class instance. Structures are always copied when they are passed around in your code, and do not use reference counting.
 */


/*
 * 10.2 Definition Syntax
 */

// 因为定义类和结构体时相当于定义了一种新的类型，所以类名和结构体名都应该以大写字母开头
class SomeClass {
    // class definition goes here
}
struct SomeStructure {
    // structure definition goes here
}

struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}


/*
 * 10.3 Class and Structure Instances
 */

// creating instances
let someResolution = Resolution()
let someVideoMode = VideoMode()

// Accessing Properties
someResolution.width
someVideoMode.resolution.width
someVideoMode.resolution.width = 1280
someVideoMode.resolution.width

// Memberwise Initializers for Structure Types
let vga = Resolution(width: 640, height: 480)


/*
 * 10.4 Structures and Enumerations Are Value Types
 */

// A value type is a type that is copied when it is assigned to a variable or constant, or when it is passed to a function. In fact, all of the basic types in Swift—integers, floating-point numbers, Booleans, strings, arrays and dictionaries—are value types, and are implemented as structures behind the scenes.
// All structures and enumerations are value types in Swift.
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
hd

enum CompassPoint {
    case North, South, East, West
}
var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    println("The remembered direction is still .West")
}


/*
 * 10.5 Classes Are Reference Types
 */

// Unlike value types, reference types are not copied when they are assigned to a variable or constant, or when they are passed to a function. Rather than a copy, a reference to the same existing instance is used instead.
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
alsoTenEighty.frameRate
tenEighty.frameRate


/*
 * 10.6 Identity Operators
 */

/*
find out if two constants or variables refer to exactly the same instance of a class:
1.Identical to (===)
2.Not identical to (!==)
 */
tenEighty === alsoTenEighty
tenEighty !== alsoTenEighty

/*
"Identical to" means that two constants or variables of class type refer to exactly the same class instance.
"Equal to" means that two instances are considered “equal” or “equivalent” in value, for some appropriate meaning of “equal”, as defined by the type’s designer.
 */

/*
Swift variable or constant and Pointers in C/C++/OC
If you have experience with C, C++, or Objective-C, you may know that these languages use pointers to refer to addresses in memory. A Swift constant or variable that refers to an instance of some reference type is similar to a pointer in C, but is not a direct pointer to an address in memory, and does not require you to write an asterisk (*) to indicate that you are creating a reference. Instead, these references are defined like any other constant or variable in Swift.
 */


/*
 * 10.7 Choosing Between Classes and Structures
 */

/*
choose structures:
1.The structure’s primary purpose is to encapsulate a few relatively simple data values.
2.It is reasonable to expect that the encapsulated values will be copied rather than referenced when you assign or pass around an instance of that structure.
3.Any properties stored by the structure are themselves value types, which would also be expected to be copied rather than referenced.
4.The structure does not need to inherit properties or behavior from another existing type.

剩下的场合choose classes
 */


/*
 * 10.8 Assignment and Copy Behavior for Dictionaries
 */

// Swift’s Array and Dictionary types are implemented as structures.

// Whenever you assign a Dictionary instance to a constant or variable, or pass a Dictionary instance as an argument to a function or method call, the dictionary is copied at the point that the assignment or call takes place.
var ages = ["Peter": 23, "Wei": 35, "Anish": 65, "Katya": 19]
var copiedAges = ages
copiedAges["Peter"] = 24
copiedAges["Peter"]
ages["Peter"]

// The assignment and copy behavior for Swift’s Array type is more complex than for its Dictionary type. Array provides C-like performance when you work with an array’s contents and copies an array’s contents only when copying is necessary.

// If you assign an Array instance to a constant or variable, or pass an Array instance as an argument to a function or method call, the contents of the array are not copied at the point that the assignment or call takes place.
var a = [1, 2, 3]
var b = a
var c = a
a[0]
b[0]
c[0]
a[0] = 42
a[0]
b[0]
c[0]

// For arrays, copying only takes place when you perform an action that has the potential to modify the length of the array. This includes appending, inserting, or removing items, or using a ranged subscript to replace a range of items in the array.
// However, if you append a new item to a, you do modify the array’s length. This prompts Swift to create a new copy of the array at the point that you append the new value. Henceforth, a is a separate, independent copy of the array.
a
b
c
a.append(4)
a
b
c

// It can be useful to ensure that you have a unique copy of an array before performing an action on that array’s contents, or before passing that array to a function or method. You ensure the uniqueness of an array reference by calling the unshare method on a variable of array type. (The unshare method cannot be called on a constant array.)
// If multiple variables currently refer to the same array, and you call the unshare method on one of those variables, the array is copied, so that the variable has its own independent copy of the array. 
// 注意：However, no copying takes place if the variable is already the only reference to the array.
b === c
b.unshare()
b === c
b
c
b[0] = -105
b
c

// Check whether two arrays or subarrays share the same storage and elements by comparing them with the identity operators (=== and !==).
a === b
b === c
b[0...1] === b[0...1]


/*
 * 10.9 Forcing a Copy of an Array
 */

var names = ["Mohsen", "Hilary", "Justyn", "Amy", "Rich", "Graham", "Vic"]
var copiedNames = names.copy()
names === copiedNames
names[0]
copiedNames[0]
copiedNames[0] = "Mo"
names[0]
copiedNames[0]

// If you simply need to be sure that your reference to an array’s contents is the only reference in existence, call the unshare method, not the copy method. The unshare method does not make a copy of the array unless it is necessary to do so.（例如只有一个引用指向数组时，调用unshare方法不会进行复制） The copy method always copies the array, even if it is already unshared.


/*
 * 5.1 Collection Types
 */

// Swift provides two collection types, known as arrays and dictionaries, for storing collections of values.

/*
 * 5.2 Array Literals
 */

var shoppingList: String[] = ["Eggs", "Milk"]

// Because all values in the array literal are of the same type, Swift can infer that String[] is the correct type to use for the shoppingList_interred variable.
var shoppingList_interred = ["Eggs", "Milk"]


/*
 * 5.3 Accessing and Modifying an Array
 */

// find out the number of items in an array
shoppingList.count

// Use the Boolean isEmpty property as a shortcut for checking whether the count property is equal to 0
var emptyArray: String[] = []
if emptyArray.isEmpty {
    println("The emptyArray is empty.")
} else {
    println("The emptyArray is not empty.")
}

// add a new item to the end of an array by calling the array’s append method
shoppingList.append("Flour")
shoppingList
shoppingList += "Baking Powder"
shoppingList

// append an array of compatible items
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]

// Retrieve a value from the array by using subscript syntax
var firstItem = shoppingList[0]

// use subscript syntax to change an existing value
shoppingList[0] = "Six eggs"

// use subscript syntax to change a range of values
shoppingList
shoppingList[4...6] = ["Bananas", "Apples"]
shoppingList // 此时第6个元素没了

// You can’t use subscript syntax to append a new item to the end of an array. If you try to use subscript syntax to retrieve or set a value for an index that is outside of an array’s existing bounds, you will trigger a runtime error.
//shoppingList[6] = "1"
/*
报错信息如下（运行时错误）：
fatal error: Array index out of range
Playground execution failed: error: Execution was interrupted, reason: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0).
The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.
* thread #1: tid = 0x434d5, 0x00000001067d713f, queue = 'com.apple.main-thread', stop reason = EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0)
* frame #0: 0x00000001067d713f
 */

// To insert an item into the array at a specified index, call the array’s insert(atIndex:) method
shoppingList.insert("Maple Syrup", atIndex: 0)
shoppingList

// remove an item from the array with the removeAtIndex method
let mapleSyrup = shoppingList.removeAtIndex(0)
shoppingList

// If you want to remove the final item from an array, use the removeLast method rather than the removeAtIndex method to avoid the need to query the array’s count property.
let apples = shoppingList.removeLast()
shoppingList

// Iterating Over an Array
for item in shoppingList {
    println(item)
}

// If you need the integer index of each item as well as its value, use the global enumerate function to iterate over the array instead. The enumerate function returns a tuple for each item in the array composed of the index and the value for that item.
for (index, value) in enumerate(shoppingList) {
    println("Item \(index + 1): \(value)")
}


/*
 * 5.4 Creating and Initializing an Array
 */

// create an empty array of a certain type using initializer syntax
var someInts = Int[]()
someInts.count

// if the context already provides type information, you can create an empty array with an empty array literal, which is written as []
someInts.append(3)
someInts = []

// an initializer for creating an array of a certain size with all of its values set to a provided default value
var threeDoubles = Double[](count: 3, repeatedValue: 1.0)

// type can be inferred from the default value
var anotherThreeDoubles = Array(count: 3, repeatedValue: 2.5)

// create a new array by adding together two existing arrays of compatible type with the addition operator (+)
var sixDoubles = threeDoubles + anotherThreeDoubles
// sixDoubles is inferred as Double[]


/*
 * 5.5 Dictionaries
 */

// The only restriction is that KeyType must be hashable—that is, it must provide a way to make itself uniquely representable. All of Swift’s basic types (such as String, Int, Double, and Bool) are hashable by default, and all of these types can be used as the keys of a dictionary. Enumeration member values without associated values are also hashable by default.


/*
 * 5.6 Dictionary Literals
 */
var airports: Dictionary<String, String> = ["TYO": "Tokyo", "DUB": "Dublin"]
var airports_dictionary = ["TYO": "Tokyo", "DUB": "Dublin"]

/*
 * 5.7 Accessing and Modifying a Dictionary
 */

// find out the number of items in a Dictionary
airports.count

// Use a new key of the appropriate type as the subscript index, and assign a new value of the appropriate type to add a new item to a dictionary
airports["LHR"] = "London"
airports

// change the value associated with a particular key
airports["LHR"] = "London Heathrow"
airports

// the updateValue(forKey:) method sets a value for a key if none exists, or updates the value if that key already exists. Unlike a subscript, however, the updateValue(forKey:) method returns the old value after performing an update. The updateValue(forKey:) method returns an optional value of the dictionary’s value type.
if let oldValue = airports.updateValue("Dublin International", forKey: "DUB") {
    oldValue
}

// subscript syntax also returns an optional value
if let airportName = airports["DUB"] {
    println("The name of the airport is \(airportName).")
} else {
    println("That airport is not in the airports dictionary.")
}

// use subscript syntax to remove a key-value pair
airports["APL"] = "Apple International"
airports
airports["APL"] = nil // 删除APL这一个key-value对
airports

// removeValueForKey method removes the key-value pair if it exists and returns the removed value, or returns nil if no value existed
if let removedValue = airports.removeValueForKey("DUB") {
    removedValue
}


/*
 * 5.8 Iterating Over a Dictionary
 */

// for-in loop
for (airportCode, airportName) in airports {
    println("\(airportCode): \(airportName)")
}

// retrieve an iteratable collection of a dictionary’s keys or values
for airportCode in airports.keys {
    println("Airport code: \(airportCode)")
}
for airportName in airports.values {
    println("Airport name: \(airportName)")
}

// use a dictionary’s keys or values with an API that takes an Array instance
let airportCodes = Array(airports.keys)
let airportNames = Array(airports.values)


/*
 * 5.9 Creating an Empty Dictionary
 */

var namesOfIntegers = Dictionary<Int, String>()

// If the context already provides type information, create an empty dictionary with an empty dictionary literal, which is written as [:]
namesOfIntegers[16] = "sixteen"
namesOfIntegers = [:]


/*
 * 5.10 Mutability of Collections
 */

// For arrays, if you assign an array or a dictionary to a constant, that array or dictionary is immutable, and its size cannot be changed.
let constantArray = [1, 2, 3]
//constantArray[4] = 4 // 常数组不能再添加新元素，运行时会报错

// You are still not allowed to perform any action that has the potential to change the size of an immutable array, but you are allowed to set a new value for an existing index in the array. This enables Swift’s Array type to provide optimal performance for array operations when the size of an array is fixed.
constantArray[0] = 0
constantArray
// 数组常量：数组长度不变，但是数组中的元素内容可变

// For dictionaries, immutability means that you cannot replace the value for an existing key in the dictionary. An immutable dictionary’s contents cannot be changed once they are set.
let constantDictionary = ["1": 1, "2": 2, "3": 3]
//constantDictionary["1"] = 0 // Error
// 字典常量：内容不能改变

// 用不可变集合元素更好：It is good practice to create immutable collections in all cases where the collection’s size does not need to change. Doing so enables the Swift compiler to optimize the performance of the collections you create.


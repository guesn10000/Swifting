/*
 * 18.1 Optional Chaining as an Alternative to Forced Unwrapping
 */

class Person {
    var residence: Residence? // default is nil
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()
//let roomCount = john.residence!.numberOfRooms // this triggers a runtime error

if let roomCount = john.residence?.numberOfRooms {
    roomCount
} else {
    -1
}

john.residence = Residence()
if let roomCount = john.residence?.numberOfRooms {
    roomCount
} else {
    -1
}


/*
 * 18.2 Defining Model Classes for Optional Chaining
 */

class MPerson {
    var residence: MResidence?
}

class MResidence {
    var rooms = [MRoom]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> MRoom {
        return rooms[i]
    }
    func printNumberOfRooms() {
        println("The number of rooms is \(numberOfRooms)")
    }
    var address: MAddress?
}

class MRoom {
    let name: String
    init(name: String) { self.name = name }
}

class MAddress {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName {
            return buildingName
        } else if buildingNumber {
            return buildingNumber
        } else {
            return nil
        }
    }
}


/*
 * 18.3 Calling Properties Through Optional Chaining
 */

let mjohn = MPerson()
if let roomCount = mjohn.residence?.numberOfRooms {
    roomCount
} else {
    -1
}


/*
 * 18.4 Calling Methods Through Optional Chaining
 */

if mjohn.residence?.printNumberOfRooms() {
    println("It was possible to print the number of rooms.")
} else {
    println("It was not possible to print the number of rooms.")
}
// prints "It was not possible to print the number of rooms.”


/*
 * 18.5 Calling Subscripts Through Optional Chaining
 */

if let firstRoomName = mjohn.residence?[0].name {
    firstRoomName
} else {
    "Unknown"
}


let johnsHouse = MResidence()
johnsHouse.rooms += MRoom(name: "Living Room")
johnsHouse.rooms += MRoom(name: "Kitchen")
mjohn.residence = johnsHouse

if let firstRoomName = mjohn.residence?[0].name {
    firstRoomName
} else {
    "Unknown"
}


/*
 * 18.6 Linking Multiple Levels of Chaining
 */

if let johnsStreet = mjohn.residence?.address?.street {
    johnsStreet
} else {
    "Unknown"
}


let johnsAddress = MAddress()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
mjohn.residence!.address = johnsAddress

if let johnsStreet = mjohn.residence?.address?.street {
    johnsStreet
} else {
    "Unknown"
}


/*
 * 18.7 Chaining on Methods With Optional Return Values
 */

if let buildingIdentifier = mjohn.residence?.address?.buildingIdentifier() {
    buildingIdentifier
}


if let upper = mjohn.residence?.address?.buildingIdentifier()?.uppercaseString {
    upper
}


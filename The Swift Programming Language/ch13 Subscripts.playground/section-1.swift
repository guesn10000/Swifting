/*
 * 13.1 Subscript（下标） Syntax
 */

/*
// syntax example
subscript(index: Int) -> Int {
    get {
        // return an appropriate subscript value here
    }
    set(newValue) { // newValue is default
        // perform a suitable setting action here
    }
}
 */

/*
// As with read-only computed properties, you can drop the get keyword for read-only subscripts:
subscript(index: Int) -> Int {
    // return an appropriate subscript value here
}
 */

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
threeTimesTable[6]
//threeTimesTable[6] = 10 // Error: read-only subscripts cann't be assigned


/*
 * 13.2 Subscript Usage
 */

// Subscripts are typically used as a shortcut for accessing the member elements in a collection, list, or sequence. You are free to implement subscripts in the most appropriate way for your particular class or structure’s functionality.
// Swift’s Dictionary type implements its key-value subscripting as a subscript that takes and receives an optional type.
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2


/*
 * 13.3 Subscript Options
 */

// Subscripts can take any number of input parameters, and these input parameters can be of any type. Subscripts can also return any type. Subscripts can use variable parameters and variadic parameters, but cannot use in-out parameters or provide default parameter values.
// A class or structure can provide as many subscript implementations as it needs, and the appropriate subscript to be used will be inferred based on the types of the value or values that are contained within the subscript braces at the point that the subscript is used. This definition of multiple subscripts is known as subscript overloading.
struct Matrix {
    let rows: Int, columns: Int
    var grid: Double[]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2
let someValue = matrix[2, 2] // this triggers an assert, because [2, 2] is outside of the matrix bounds




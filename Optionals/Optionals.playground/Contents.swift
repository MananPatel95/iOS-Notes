import Foundation

// Swift Optionals Explained

// What are Optionals?
// Optionals in Swift represent the possibility of absence in a constant or variable. An optional can either contain a value or be `nil`

// Optionals are actually an enumeration (enum) with two cases
// enum Optional<Wrapped> {
//    case none
//    case some(Wrapped)
// }
Optional
var possibleNumber: Int? = 42
possibleNumber = nil // This is valid

// Force Unwrapping
// Force unwrapping is a way to access the value inside an optional, assuming it's not `nil`.

possibleNumber = 42
let forcedNumber = possibleNumber!
print("Forced unwrapping result: \(forcedNumber)")


// Implicit Unwrapping
// Implicit unwrapping declares an optional that can be used as if it were already unwrapped.

var assumedNumber: Int! = 42
let implicitNumber: Int = assumedNumber
print("Implicit unwrapping result: \(implicitNumber)")


// Optional Binding

// if let
if let actualNumber = possibleNumber {
    print("The number is \(actualNumber)")
} else {
    print("The optional was nil")
}

// guard let
func processNumber(_ number: Int?) {
    guard let unwrappedNumber = number else {
        print("No number provided")
        return
    }
    print("Processing number: \(unwrappedNumber)")
}

processNumber(possibleNumber)
processNumber(nil)

// Why use guard over if let?
// 1. Early Exit
// 2. Scope: Variables unwrapped with `guard` are available for the rest of the function
// 3. Readability: Reduces nesting and separates error handling from the main logic

func processNumberWithIfLet(_ number: Int?) {
    if let unwrappedNumber = number {
        print("If-Let: Processing number: \(unwrappedNumber)")
    } else {
        print("If-Let: No number provided")
    }
    // Can't use unwrappedNumber here
}

func processNumberWithGuard(_ number: Int?) {
    guard let unwrappedNumber = number else {
        print("Guard: No number provided")
        return
    }
    print("Guard: Processing number: \(unwrappedNumber)")
    // Can use unwrappedNumber here
}

processNumberWithIfLet(42)
processNumberWithIfLet(nil)
processNumberWithGuard(42)
processNumberWithGuard(nil)

// Optional Chaining
class Residence {
    var numberOfRooms = 1
}

class Person {
    var residence: Residence?
}

let john = Person()

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

john.residence = Residence()

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

// Optional chaining fails gracefully when the optional is `nil`.

// Remember, while force unwrapping and implicit unwrapping can be convenient,
// they should be used sparingly and with caution. Optional binding (especially `guard let`)
// and optional chaining are generally safer alternatives that help prevent runtime crashes
// and make your code more robust and readable.

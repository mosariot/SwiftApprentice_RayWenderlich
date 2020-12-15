import Foundation

// CHAPTER CODE

let coordinate = (x: 1, y: 0, z: 0)

if (coordinate.y == 0) && (coordinate.z == 0) {
    print("along the x-axis")
}

if case (_, 0, 0) = coordinate {
    print("along the x-axis")
}

func processIf(point: (x: Int, y: Int, z: Int)) -> String {
    if case (0, 0, 0) = point {
        return "At origin"
    }
    return "Not at origin"
}

var point = (x: 0, y: 0, z: 0)
var status = processIf(point: point)

func processGuard(point: (x: Int, y: Int, z: Int)) -> String {
    guard case (0, 0, 0) = point else {
        return "Not at origin"
    }
    return "At origin"
}

status = processGuard(point: point)

func processSwitch(point: (x: Int, y: Int, z: Int)) -> String {
    let closeRange = -2...2
    let midRange = -5...5
    
    switch point {
    case (0, 0, 0):
        return "At origin"
    case (closeRange, closeRange, closeRange):
        return "Very close to origin"
    case (midRange, midRange, midRange):
        return "Nearby origin"
    default:
        return "Not near origin"
    }
}

point = (x: 15, y: 5, z: 3)
status = processSwitch(point: point)

let population = 5
switch population {
case ...0:
    print("No people at all")
case 1:
    print("Single person")
case 2...5:
    print("A few people")
case 6...10:
    print("A several people")
case 10...:
    print("Many people")
default:
    break
}

let groupSizes = [1, 5, 4, 6, 2, 1, 3]
for case 1 in groupSizes {
    print("Found an individual")
}

if case (let x, 0, 0) = coordinate {
    print("On the x-axis at \(x)")
}

if case let (x, y, 0) = coordinate {
    print("On the x-y plane at (\(x), \(y)")
}

enum Direction {
    case north, south, east, west
}

let heading = Direction.north
if case .north = heading {
    print("Don't forget  your jacket")
}

enum Organism {
    case plant
    case animal(legs: Int)
}
let pet = Organism.animal(legs: 4)
switch pet {
case .animal(let legs):
    print("Potentially cuddly with \(legs) legs")
default:
    print("No chance for cuddles")
}

let names: [String?] = ["Michelle", nil, "Brandon", "Christine", nil, "David"]
for case .some(let name) in names {
    print(name)
}
//for i in 0...names.count-1 {
//    if let name = names[i] {
//        print(name)
//    }
//}
//names
//    .compactMap{ $0 }
//    .forEach{ print($0) }

for case let name? in names {
    print(name)
}

let response: [Any] = [15, "George", 2.0]
for element in response {
    switch element {
    case is String:
        print("Found a string")
    default:
        print("Found something else")
    }
}
for element in response {
    switch element {
    case let text as String:
        print("Found a string: \(text)")
    default:
        print("Found something else")
    }
}

for number in 1...9 {
    switch number {
    case let x where x % 2 == 0:
        print("even")
    default:
        print("odd")
    }
}

enum LevelStatus {
    case complete
    case inProgress(percent: Double)
    case notStasted
}

let levels: [LevelStatus] = [.complete, .inProgress(percent: 0.9), .notStasted]

for level in levels {
    switch level {
    case .inProgress(let percent) where percent > 0.8:
        print("Almost there!")
    case .inProgress(let percent) where percent > 0.5:
        print("Halfway there!")
    case .inProgress(let percent) where percent > 0.2:
        print("Made it through the beginning")
    default:
        break
    }
}

func timeOfDayDescription(hour: Int) -> String {
    switch hour {
    case 0, 1, 2, 3, 4, 5:
        return "Early morning"
    case 6, 7, 8, 9, 10, 11:
        return "Morning"
    case 12, 13, 14, 15, 16:
        return "Afternoon"
    case 17, 18, 19:
        return "Evening"
    case 20, 21, 22, 23:
        return "Late evening"
    default:
        return "INVALID HOUR!"
    }
}

let timeOfDay = timeOfDayDescription(hour: 12)

if case .animal(let legs) = pet, case 2...4 = legs {
    print("potentially cuddly")
} else {
    print("no chance for cuddles")
}

enum Number {
    case integerValue(Int)
    case doubleValue(Double)
    case booleanValue(Bool)
}

let a = 5
let b = 6
let c: Number? = .integerValue(7)
let d: Number? = .integerValue(8)

if a != b {
    if let c = c {
        if let d = d {
            if case .integerValue(let cValue) = c {
                if case .integerValue(let dValue) = d {
                    if dValue > cValue {
                        print("a and b are different")
                        print("d is greater than c")
                        print("sum: \(a + b + cValue + dValue)")
                    }
                }
            }
        }
    }
}

if a != b,
    let c = c,
    let d = d,
    case .integerValue(let cValue) = c,
    case .integerValue(let dValue) = d,
    dValue > cValue {
    print("a and b are different")
    print("d is greater than c")
    print("sum: \(a + b + cValue + dValue)")
}

let name = "Bob"
let age = 23
if case ("Bob", 23) = (name, age) {
    print("Found the right Bob")
}

var username: String?
var password: String?
switch (username, password) {
case let (username?, password?):
    print("Success! User: \(username) Pass: \(password)")
case let (username?, nil):
    print("Password is missing. User: \(username)")
case let (nil, password?):
    print("Username is missing. Pass: \(password)")
case (nil, nil):
    print("Both username and password are missing")
}

for _ in 1...3 {
    print("Hi!")
}

let user: String? = "Bob"
guard let _ = user else {
    print("There is no user")
    fatalError()
}
print("User exists, but identity not needed")

guard user != nil else {
    print("There is no user.")
    fatalError()
}

struct Rectangle {
    let width: Int
    let height: Int
    let background: String
}
let view = Rectangle(width: 15, height: 60, background: "Green")
switch view {
case _ where view.height < 50:
    print("Shorter than 50 units")
case _ where view.width > 20:
    print("Over 50 tall & over 20 wide")
case _ where view.background == "Green":
    print("Over 50 tall, at most 20 wide & green")
default:
    print("This view can't be described by this example")
}

func fibonacci(position: Int) -> Int {
    switch position {
    case _ where position <= 1:
        return 0
    case 2:
        return 1
    case let n:
        return fibonacci(position: n - 1) + fibonacci(position: n - 2)
    }
}
let fib15 = fibonacci(position: 15)

for i in 1...100 {
    switch (i % 3, i % 5) {
    case (0, 0):
        print("FizzBuzz", terminator: " ")
    case (0, _):
        print("Fizz", terminator: " ")
    case (_, 0):
        print("Buzz", terminator: " ")
    case (_, _):
        print(i, terminator: " ")
    }
}
print("")

let matched = (1...10 ~= 5)
if case 1...10 = 5 {
    print("In the range")
}

func ~=(pattern: [Int], value: Int) -> Bool {
    for i in pattern {
        if i == value {
            return true
        }
    }
    return false
}

let list = [0, 1, 2, 3]
let integer = 2

let isInArray = (list ~= integer)
if case list = integer {
    print("The integer is in the array")
} else {
    print("The integer is not in the array")
}

// CHALLENGES

// 1

enum FormField {
    case firstName(String)
    case lastName(String)
    case emailAddress(String)
    case age(Int)
}
let minimumAge = 21
let submittedAge = FormField.age(22)

if case .age(let years) = submittedAge, years > minimumAge {
    print("Welcome!")
} else {
    print("You're too young!")
}

// 2

enum CelestialBody {
    case star
    case planet(liquidWater: Bool)
    case comet
}

let telescopeCensus = [
    CelestialBody.star,
    .planet(liquidWater: false),
    .planet(liquidWater: true),
    .planet(liquidWater: true),
    .comet]

for case .planet(let water) in telescopeCensus where water {
    print("Found a planet with liquid water")
}

// 3

let queenAlbums = [
    ("A Night at the Opera", 1974),
    ("Sheer Heart Attack", 1974),
    ("Jazz", 1978),
    ("The Game", 1980)
]

for case (let name, 1974) in queenAlbums {
    print("Found an album released in 1974 - \(name)")
}

// 4

let coordinates = (lat: 192.89483, long: -68.887463)

switch coordinates {
case (let x, _) where x > 0:
    print("Northern hemisphere")
case (let x, _) where x < 0:
    print("Southern hemishpere")
default:
    print("Equator")
}

import Foundation

// CHAPTER CODE

// custom operators

infix operator **: ExponentialPrecedence

func **(base: Int, power: Int) -> Int {
    precondition(power >= 2)
    var result = base
    for _ in 2...power {
        result *= base
    }
    return result
}

let base = 2
let exponent = 3
let result = base ** exponent

infix operator **=

func **=(lhs: inout Int, rhs: Int) {
    lhs = lhs ** rhs
}

var number = 3
number **= exponent

infix operator **!

func **!(base: String, multiplier: Int) -> String {
    precondition(multiplier >= 2)
    var result = base
    for _ in 2...multiplier {
        result += base
    }
    return result
}

let baseString = "abc"
let times = 5
var multipliedString = baseString **! times

infix operator **!=

func **!=(lhs: inout String, rhs: Int) {
    lhs = lhs **! rhs
}

multipliedString **!= times

func **<T: BinaryInteger>(base: T, power: Int) -> T {
    precondition(power >= 2)
    var result = base
    for _ in 2...power {
        result *= base
    }
    return result
}

func **=<T: BinaryInteger>(lhs: inout T, rhs: Int) {
    lhs = lhs ** rhs
}

let unsignedBase: UInt = 2
let unsignedResult = unsignedBase ** exponent

let base8: Int8 = 2
let result8 = base8 ** exponent

let unsignedBase8: UInt8 = 2
let unsignedResult8 = unsignedBase8 ** exponent

let base16: Int16 = 2
let result16 = base16 ** exponent

let unsignedBase16: UInt16 = 2
let unsignedResult16 = unsignedBase16 ** exponent

let base32: Int32 = 2
let result32 = base32 ** exponent

let unsignedBase32: UInt32 = 2
let unsignedResult32 = unsignedBase32 ** exponent

let base64: Int64 = 2
let result64 = base64 ** exponent

let unsignedBase64: UInt64 = 2
let unsignedResult64 = unsignedBase64 ** exponent

precedencegroup ExponentialPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

2 * 2 ** 2 ** 2


// subscripts

class Person {
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let me = Person(name: "Alex", age: 38)

extension Person {
    subscript(property key: String) -> String? {
        switch key {
        case "name":
            return name
        case "age":
            return "\(age)"
        default:
            return nil
        }
    }
}

me[property: "name"]
me[property: "age"]
me[property: "gender"]

class File {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    static subscript(key: String) -> String {
        switch key {
        case "path":
            return "custom path"
        default:
            return "default path"
        }
    }
}

File["path"]
File["PATH"]

// dynamic member lookup

@dynamicMemberLookup
class Instrument {
    let brand: String
    let year: Int
    private let details: [String: String]
    
    init(brand: String, year: Int, details: [String: String]) {
        self.brand = brand
        self.year = year
        self.details = details
    }
    
    subscript(dynamicMember key: String) -> String {
        switch key {
        case "info":
            return "\(brand) \(year)."
        default:
            return details[key] ?? ""
        }
    }
}

let instrument = Instrument(brand: "Roland", year: 2019, details: ["type": "acoustic", "pitch": "C"])

instrument.info
instrument.pitch

class Guitar: Instrument {}

let guitar = Guitar(brand: "Fender", year: 2019, details: ["type": "electric", "pitch": "C"])

guitar.info

@dynamicMemberLookup
class Folder {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    class subscript(dynamicMember key: String) -> String {
        switch key {
        case "path":
            return "custom path"
        default:
            return "dafault path"
        }
    }
}

Folder.path
Folder.PATH

class Tutorial {
    let title: String
    let author: Person
    let details: (type: String, category: String)
    
    init(title: String, author: Person, details: (type: String, category: String)) {
        self.title = title
        self.author = author
        self.details = details
    }
}

let tutorial = Tutorial(title: "Object Oriented Programming in Swift", author: me, details: (type: "Swift", category: "iOS"))

let title = \Tutorial.title
let tutorialTitle = tutorial[keyPath: title]

let authorName = \Tutorial.author.name
var tutorialAuthor = tutorial[keyPath: authorName]

let type = \Tutorial.details.type
let tutorialType = tutorial[keyPath: type]
let category = \Tutorial.details.category
let tutorialCategory = tutorial[keyPath: category]

let authorPath = \Tutorial.author
let authorNamePath = authorPath.appending(path: \.name)
tutorialAuthor = tutorial[keyPath: authorNamePath]

class JukeBox {
    var song: String
    
    init(song: String) {
        self.song = song
    }
}

let jukebox = JukeBox(song: "Nothing Else Matters")
let song = \JukeBox.song
jukebox[keyPath: song] = "Stairway to Heaven"

struct Point {
    let x, y: Int
}

@dynamicMemberLookup
struct Circle {
    let center: Point
    let radius: Int
    
    subscript(dynamicMember keyPath: KeyPath<Point, Int>) -> Int {
        center[keyPath: keyPath]
    }
}

let center = Point(x: 1, y: 2)
let circle = Circle(center: center, radius: 1)
circle.x
circle.y

// CHALLENGES

// 1

extension Array {
    subscript(aboutInt index: Int) -> (String, String)? {
        guard let value = self[index] as? Int else {
            return nil
        }
        switch (value >= 0, abs(value) % 2) {
        case (true, 0):
            return ("positive", "even")
        case (true, 1):
            return ("positive", "odd")
        case (false, 0):
            return ("negative", "even")
        case (false, 1):
            return ("negative", "odd")
        default:
            return nil
        }
    }
}

let array = [4,6,-7846,7,-45,67]
array[aboutInt: 3]

// 2

extension String {
    subscript(char index: Int) -> Character? {
        guard (0..<count).contains(index) else {
            return nil
        }
        return self[self.index(self.startIndex, offsetBy: index - 1)]
    }
}

let string = "abcde\u{301}"
string[char: 0]
string[char: 4]
string[char: 5]
string[char: 3]


// 3

func **<T: BinaryFloatingPoint>(base: T, power: Int) -> T {
    precondition(power >= 2)
    var result = base
    for _ in 2...power {
        result *= base
    }
    return result
}

let baseDouble = 2.0
var resultDouble = baseDouble ** exponent

let baseFloat: Float = 2.0
var resultFloat = baseFloat **  exponent

let baseCG: CGFloat = 2.0
var resultCG = baseCG ** exponent

// 4

func **=<T: BinaryFloatingPoint>(lhs: inout T, rhs: Int) {
    lhs = lhs ** rhs
}

resultDouble **= exponent
resultFloat **= exponent
resultCG **= exponent

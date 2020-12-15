import Foundation

// CHAPTER CODE

// stored, default properties
 
struct Contact {
    var fullName: String
    var emailAddress: String
    var relationship = "Friend"
}
 
var person = Contact(fullName: "Grace Muller", emailAddress: "grace@navi.mil")
let name = person.fullName
let email = person.emailAddress
person.fullName = "Grace Hopper"
let grace = person.fullName
 
person.relationship
 
var boss = Contact(fullName: "Ray Wenderlich", emailAddress: "ray@raywenderlich.com", relationship: "Boss")
 
// computed properties, getter/setter
 
struct TV {
    var height: Double
    var width: Double
    var diagonal: Int {
        get {
            let result = (height * height + width * width).squareRoot().rounded()
            return Int(result)
        }
        set {
            let ratioWidth = 16.0
            let ratioHeight = 9.0
            let ratioDiagonal = (ratioWidth * ratioWidth + ratioHeight * ratioHeight).squareRoot()
            height = Double(newValue) * ratioHeight / ratioDiagonal
            width = height * ratioWidth / ratioHeight
        }
    }
}
 
var tv = TV(height: 53.93, width: 95.87)
let size = tv.diagonal
 
tv.width = tv.height
let diagonal = tv.diagonal
 
tv.diagonal = 70
let height = tv.height
let width = tv.width
 
// type properties, willset/didset
 
struct Level {
    static var highestLevel = 1
    let id: Int
    var boss: String
    var unlocked: Bool {
        didSet {
            if unlocked && id > Self.highestLevel {
                Self.highestLevel = id
            }
        }
    }
}
 
let level1 = Level(id: 1, boss: "Chameleon", unlocked: true)
let level2 = Level(id: 1, boss: "Squid", unlocked: false)
let level3 = Level(id: 1, boss: "Chupacabra", unlocked: false)
let level4 = Level(id: 1, boss: "Yeti", unlocked: false)
let highestLevel = Level.highestLevel

struct LightBulb {
    static let maxCurrent = 40
    var current = 0 {
        willSet {
            
            }
        
        didSet {
            if current > Self.maxCurrent {
                print("""
                      Current is too high,
                      falling back to previous setting.
                      """)
                current = oldValue
            }
        }
    }
}

var light = LightBulb()
light.current = 50
var current = light.current
light.current = 40
current

// lazy properties

struct Circle {
    lazy var pi = {
        ((4.0 * atan(1.0 / 5.0)) - atan (1.0 / 239.0)) * 4.0
    }()
    var radius  = 0.0
    var circumference: Double {
        mutating get {
            pi * radius * 2
        }
    }
    init(radius: Double) {
        self.radius = radius
    }
}

var circle = Circle(radius: 5) // got a circle, pi has not been run
let circumference = circle.circumference // pi now has a value

// CHALLENGES

// 1

struct IceCream {
    let name = "Alexandr"
    lazy var ingredients = ["blueberry", "chocolade", "waffles"]
}

// 2

struct FuelTank {
    var level: Double {
        didSet {
            if level > 1 {
                level = 1
            }
            if level < 0 {
                level = 0
            }
            if level <= 0.1 {
                lowFuel = true
            }
            if level > 0.1 {
                lowFuel = false
            }
        }
    }
    var lowFuel: Bool
}

struct Car {
    let make: String
    let color: String
    var fuel: FuelTank
}

var car = Car(make: "Kia", color: "Urban Grey", fuel: FuelTank(level: 0.5, lowFuel: false))
car.fuel.lowFuel
car.fuel.level = 0.05
car.fuel.lowFuel
car.fuel.level = 0.7
car.fuel.lowFuel

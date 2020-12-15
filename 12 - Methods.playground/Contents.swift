import Foundation

// CHAPTER CODE

let months = ["January", "February", "March",
              "April", "May", "June",
              "July", "August", "September",
              "October", "November", "December"]

struct SimpleDate {
    var month: String
    var day: Int
    
    init() {
        month = "January"
        day = 1
    }
    
    // as method:
    func monthsUntilWinterBreakMethod() -> Int {
        months.firstIndex(of: "December")! - months.firstIndex(of: month)!
    }
    // as computed property:
    var monthsUntilWinterBreakCompProp: Int {
        months.firstIndex(of: "December")! - months.firstIndex(of: month)!
    }
    
    mutating func advance() {
        day += 1
    }
    
}

extension SimpleDate {
    init(month: String, day: Int) {
        self.month = month
        self.day = day
    }
}

let date = SimpleDate(month: "January", day: 1)
let simpleDate = SimpleDate()
date.monthsUntilWinterBreakMethod()
date.monthsUntilWinterBreakCompProp

let valentinesDay = SimpleDate(month: "February", day: 14)
valentinesDay.month
valentinesDay.day

struct VerySimpleDate {
    var month = "January"
    var day = 1
}

let newYearsDay = VerySimpleDate()
let octoberFirst = VerySimpleDate(month: "October")
let januaryTwentyTwo = VerySimpleDate(day: 22)

struct Math {
    static func factorial(of number: Int) -> Int {
        (1...number).reduce(1, *)
    }
    static func triangleNumber(of number: Int) -> Int {
        (0...number-1).reduce(0, +)
    }
}

extension Math {
    static func primeFactors(of value: Int) -> [Int] {
        var remainingValue = value
        var testFactor = 2
        var primes: [Int] = []
        while testFactor * testFactor <= remainingValue {
            if remainingValue % testFactor == 0 {
                primes.append(testFactor)
                remainingValue /= testFactor
            } else {
                testFactor += 1
            }
        }
        if remainingValue > 1 {
            primes.append(remainingValue)
        }
        return primes
    }
}

Math.factorial(of: 6)
Math.triangleNumber(of: 6)
Math.primeFactors(of: 88)

// CHALLENGES

// 1
 
struct Circle {
    var radius = 0.0
    var area: Double {
        get {
            .pi * radius * radius
        }
        set {
            radius = (newValue / .pi).squareRoot()
        }
    }
   
    mutating func grow(byFactor factor: Int) {
        area *= Double(factor)
    }
   
    init(radius: Double) {
        self.radius = radius
    }
}
 
var circle = Circle(radius: 5)
circle.area
circle.grow(byFactor: 3)
circle.area
 
// 2
 
struct SimpleDateAdvance {
    var month: String
    var day: Int
 
    mutating func advance() {
        switch month {
            case months[0] where day == 31,
                 months[2] where day == 31,
                 months[4] where day == 31,
                 months[6] where day == 31,
                 months[7] where day == 31,
                 months[9] where day == 31:
                month = months[months.firstIndex(of: month)! + 1]
                day = 1
            case months[11] where day == 31:
                month = months[0]
                day = 1
            case months[3] where day == 30,
                 months[5] where day == 30,
                 months[8] where day == 30,
                 months[10] where day == 30:
                month = months[months.firstIndex(of: month)! + 1]
                day = 1
            case months[1] where day == 28:
                month = months[2]
                day = 1
            default:
                day += 1
        }
    }
}
 
var trickDate = SimpleDateAdvance(month: "November", day: 25)
trickDate.advance()
trickDate.month
trickDate.day
 
// 3
 
extension Math {
    static func isOdd(of number: Int) -> Bool {
        number % 2 != 0
    }
    static func isEven(of number: Int) -> Bool {
        number % 2 == 0
    }
}
 
Math.isOdd(of: 5)
Math.isEven(of: 5)
 
// 4
 
extension Int {
    var isOdd: Bool {
        self % 2 != 0
    }
    var isEven: Bool {
        self % 2 == 0
    }
}
 
5.isOdd
5.isEven
 
// 5
 
extension Int {
    func primeFactors() -> [Int] {
        var remainingValue = self
        var testFactor = 2
        var primes: [Int] = []
        while testFactor * testFactor <= remainingValue {
            if remainingValue % testFactor == 0 {
                primes.append(testFactor)
                remainingValue /= testFactor
            } else {
                testFactor += 1
            }
        }
        if remainingValue > 1 {
            primes.append(remainingValue)
        }
        return primes
    }
}
88.primeFactors()

import Foundation

// CHAPTER CODE

let months = ["January", "February", "March", "April", "May",
              "June", "July", "August", "September", "October",
              "November", "December"]

func semester(for month: String) -> String {
    switch month {
    case "August", "September", "October", "November", "December":
        return "Autumn"
    case "January", "February", "March", "April", "May":
        return "Spring"
    default:
        return "Not in the school year"
    }
}

semester(for: "August")

enum Month: Int {
    case january = 1, february, march, april, may, june, july,
    august, september, october, november, december
    
    var semester: String {
        switch self {
        case .august, .september, .october, .november, .december:
            return "Autumn"
        case .january, .february, .march, .april, .may:
            return "Spring"
        case .june, .july:
            return "Summer holidays"
        }
    }
    
    var monthsUntilWinterBreak: Int {
        Self.december.rawValue - rawValue
    }
    
    var monthsUntilSummer: Int {
        var result = 0
        switch rawValue {
        case 1...5:
            result = Self.june.rawValue - rawValue
        case 6...8:
            result = 0
        case 9...12:
            result = Self.december.rawValue - rawValue + 6
        default:
            break
        }
        return result
    }
}

func semester(for month: Month) -> String {
    switch month {
    case .august, .september, .october, .november, .december:
        return "Autumn"
    case .january, .february, .march, .april, .may:
        return "Spring"
    case .june, .july:
        return "Summer holidays"
    }
}

var month = Month.april
semester(for: month)
month = .december
semester(for: month)

let semester = month.semester

func monthsUntilWinterBreak(from month: Month) -> Int {
    Month.december.rawValue - month.rawValue
}
monthsUntilWinterBreak(from: .april)

let fifthMonth = Month(rawValue: 5)!
monthsUntilWinterBreak(from: fifthMonth)

let monthsLeft = fifthMonth.monthsUntilWinterBreak

// string rawvalues
enum Icon: String {
    case music
    case sports
    case weather
    
    var filename: String {
        "\(rawValue).png"
    }
}

let icon = Icon.weather
icon.filename

enum Coin: Int {
    case penny = 1
    case nickel = 5
    case dime = 10
    case quarter = 25
}

let coin = Coin.quarter
coin.rawValue

let coinPurse: [Coin] = [.penny, .quarter, .nickel, .dime, .penny, .dime, .quarter]

// associated values

var balance = 100

enum WithdrawalResult {
    case success(newBalance: Int)
    case error(message: String)
}

func withdraw(amount: Int) -> WithdrawalResult {
    if amount <= balance {
        balance -= amount
        return .success(newBalance: balance)
    } else {
        return .error(message: "Not enough money")
    }
}

let result = withdraw(amount: 99)

switch result {
case .success(let newBalance):
    print("Your new balance is: \(newBalance)")
case .error(let message):
    print(message)
}

enum HTTPMethod {
    case get
    case post(body: String)
}

let request = HTTPMethod.post(body: "Hi there")
guard case .post(let body) = request else {
    fatalError("No message was posted")
}
print(body)

enum TrafficLight {
    case red, yellow, green
}
let trafficLight = TrafficLight.red

enum houseHoldLight {
    case on, off
}
let bedroomLight = houseHoldLight.on

enum Pet: CaseIterable {
    case cat, dog, bird, turtle, fish, hamster
}

for pet in Pet.allCases {
    print(pet)
}

struct Math {
    static let e = 2.7183
    static func factorial(of number: Int) -> Int {
        (1...number).reduce(1, *)
    }
}
let factorial = Math.factorial(of: 6)
let nestEgg = 25000 * pow(Math.e, 0.07 * 20)

// optionals

var age: Int?
age = 17
age = nil

switch age {
case .none:
    print("No value")
case .some(let value):
    print("Got a value: \(value)")
}

let optionalNil: Int?  = .none
optionalNil == nil
optionalNil == .none

// CHALLENGES

// 1

func totalCents(coins: [Coin]) -> Int {
    var totalCents = 0
    for coin in coins {
        totalCents += coin.rawValue
    }
    return totalCents
}
totalCents(coins: coinPurse)

// 2

let myMonth = Month.october
myMonth.monthsUntilSummer

// 3

enum Direction {
    case north
    case south
    case east
    case west
}

let movements: [Direction] = [.north, .north, .west, .south, .west, .south, .south, .east, .east, .south, .east, .west, .south]

var position = (x: 0, y: 0)

func calculatePosition(startPosition position: inout (x: Int, y: Int), movements: [Direction]) -> (Int, Int) {
    for movement in movements {
        switch movement {
        case .north:
            position.y += 1
        case .south:
            position.y -= 1
        case .east:
            position.x += 1
        case .west:
            position.x -= 1
        }
    }
    return position
}

calculatePosition(startPosition: &position, movements: movements)

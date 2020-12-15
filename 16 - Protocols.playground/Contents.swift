import Foundation

// CHAPTER CODE

protocol Vehicle {
    func accelerate()
    func stop()
}

class Unicycle: Vehicle {
    var peddling = false
    
    func accelerate() {
        peddling = true
    }
    
    func stop() {
        peddling = false
    }
}

enum Direction {
    case left
    case right
}

protocol DirectionalVehicle {
    func accelerate()
    func stop()
    func turn(_ direction: Direction)
    func description() -> String
}

protocol OptionalDirectionVehicle {
    func turn()
    func turn(_ direction: Direction)
}

protocol VehicleProperties {
    var weight: Int { get }
    var name: String { get set }
}

protocol Account {
    var value: Double { get set }
    init(initialAmount: Double)
    init?(transferAccount: Account)
}

class BitcoinAccount: Account {
    var value: Double
    required init(initialAmount: Double) {
        value = initialAmount
    }
    required init?(transferAccount: Account) {
        guard transferAccount.value > 0 else {
            return nil
        }
        value = transferAccount.value
    }
}

var accountType: Account.Type = BitcoinAccount.self
let account = accountType.init(initialAmount: 30.00)
let transferAccount = accountType.init(transferAccount: account)!

protocol WheeledVehicle: Vehicle {
    var numberOfWheels: Int { get }
    var wheelSize: Double { get set }
}

// mini-exercises

protocol Area {
    var area: Double { get }
}

struct Square: Area {
    var side: Int
    var area: Double {
        Double(side * side)
    }
}

struct Triangle: Area {
    var side1: Int
    var side2: Int
    var side3: Int
    var area: Double {
        let halfPerimeter = Double(side1 + side2 + side3) / 2
        return (halfPerimeter * (halfPerimeter - Double(side1)) * (halfPerimeter - Double(side2)) * (halfPerimeter - Double(side3))).squareRoot()
    }
}

struct Circle: Area {
    var radius: Int
    var area: Double {
        Double.pi * Double(radius * radius) / 4
    }
}

let square = Square(side: 5)
let circle = Circle(radius: 5)
let triangle = Triangle(side1: 5, side2: 5, side3: 5)

var shapes: [Area] = [square, circle, triangle]
shapes
//    .map { $0.area }
    .map(\.area)
    .forEach { print($0) }

// implementing protocols

class Bike: WheeledVehicle {
    let numberOfWheels = 2
    var wheelSize = 16.0
    
    var peddling = false
    var brakesApplied = false
    
    func accelerate() {
        peddling = true
        brakesApplied = false
    }
    
    func stop() {
        peddling = false
        brakesApplied = true
    }
}

// associated types

protocol WeightCalculatable {
    associatedtype WeightType
    var weight: WeightType { get }
}

class HeavyThing: WeightCalculatable {
    typealias WeightType = Int
    
    var weight: Int { 100 }
}

class LightThing: WeightCalculatable {
    typealias WeightType = Double
    
    var weight: Double { 0.0025 }
}

protocol Wheeled {
    var numberOfWheels: Int { get }
    var wheelSize: Double { get set }
}

class BikeMultiProtocol: Vehicle, Wheeled {
    let numberOfWheels = 2
    var wheelSize = 16.0
    
    var peddling = false
    var brakesApplied = false
    
    func accelerate() {
        peddling = true
        brakesApplied = false
    }
    
    func stop() {
        peddling = false
        brakesApplied = true
    }
}

func roundAndRound(transportation: Vehicle & Wheeled) {
    transportation.stop()
    print("The brakes are being applied to \(transportation.numberOfWheels) wheels")
}

roundAndRound(transportation: BikeMultiProtocol())

protocol Reflective {
    var typeName: String { get }
}

extension String: Reflective {
    var typeName: String {
        "I'm a String"
    }
}

let title = "Swift Apprentice"
title.typeName

class AnotherBike: Wheeled {
    var peddling  = false
    let numberOfWheels = 2
    var wheelSize = 16.0
}

extension AnotherBike: Vehicle {
    func accelerate() {
        peddling = true
    }
    
    func stop() {
        peddling = false
    }
}

protocol Named {
    var name: String { get set }
}

class ClassyName: Named {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct StructyName: Named {
    var name: String
}

var named: Named = ClassyName(name: "Classy")
var copy = named

named.name = "Still Classy"
named.name
copy.name

named = StructyName(name: "Structy")
copy = named

named.name = "Still Structy?"
named.name
copy.name

protocol NamedForClasses: class {
    var name: String { get set }
}

// standard library

// equtable

class Record {
    var wins: Int
    var loses: Int
    
    init(wins: Int, loses: Int) {
        self.wins = wins
        self.loses = loses
    }
}

let recordA = Record(wins: 10, loses: 5)
let recordB = Record(wins: 10, loses: 5)

recordA == recordB

extension Record: Equatable {
    static func ==(lhs: Record, rhs: Record) -> Bool {
        lhs.wins == rhs.wins &&
            lhs.loses == rhs.loses
    }
}

// comparable

extension Record: Comparable {
    static func <(lhs: Record, rhs: Record) -> Bool {
        if lhs.wins == rhs.wins {
            return lhs.loses > rhs.loses
        }
        return lhs.wins < rhs.wins
    }
}

let teamA = Record(wins: 14, loses: 11)
let teamB = Record(wins: 23, loses: 8)
let teamC = Record(wins: 23, loses: 9)

var leagueRecords = [teamA, teamB, teamC]

leagueRecords.sort()
leagueRecords.max()
leagueRecords.min()
leagueRecords.starts(with: [teamA, teamC])
leagueRecords.contains(teamA)

// hashable

class Student {
    let email: String
    let firstName: String
    let lastName: String
    
    init(email: String, firstName: String, lastName: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
    }
}

extension Student: Hashable {
    static func ==(lhs: Student, rhs: Student) -> Bool {
        lhs.email == rhs.email &&
            lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(email)
        hasher.combine(firstName)
        hasher.combine(lastName)
    }
}

let john = Student(email: "johnny.appleseed@apple.com", firstName: "Johnny", lastName: "Appleseed")
let lockerMap = [john: "14B"]

// customstringconvertible

print(john)

protocol CustomStringCovertible {
    var description: String { get }
}

extension Student: CustomStringConvertible {
    var description: String {
        "\(firstName) \(lastName)"
    }
}

// CHALLENGE

protocol Pet {
    func feed()
}

extension Pet {
    func feed() {
        print("Let's have a food")
    }
}

protocol Flyable: Pet {
    func cage()
}

extension Flyable {
    func cage() {
        print("Go inside the cage")
    }
}

protocol Swimmable: Pet {
    func tank()
}

extension Swimmable {
    func tank() {
        print("Go inside the tank")
    }
}

protocol Walkable: Pet {
    func walk()
}

extension Walkable {
    func walk() {
        print("Let's walk!")
    }
}

protocol Cleanable: Pet {
    func clean()
}

protocol Tankable: Swimmable, Cleanable { }

extension Tankable {
    func clean() {
        print("Clean the tank")
    }
}

protocol Cageable: Flyable, Cleanable { }

extension Cageable {
    func clean() {
        print("Clean the cage")
    }
}

struct Dog: Walkable { }
struct Cat: Walkable { }
struct Fish: Swimmable, Tankable { }
struct Bird: Flyable, Cageable { }

let myDog = Dog()
let myCat = Cat()
let myFish = Fish()
let myBird = Bird()

let feedableAnimals: [Pet] = [myCat, myDog, myFish, myBird]
let walkableAnimals: [Walkable] = [myDog, myCat]
let cleanableAnimals: [Cleanable] = [myFish, myBird]
let tankableAnimals: [Tankable] = [myFish]
let cageableAnimals: [Cageable] = [myBird]

let allAnimals: [[Pet]] = [feedableAnimals, walkableAnimals, cleanableAnimals, tankableAnimals, cageableAnimals]

for animals in allAnimals {
    if let walkableAnimals = animals as? [Walkable] {
        walkableAnimals.forEach { $0.walk() }
        continue
        }
    if let cleanableAnimals = animals as? [Cleanable] {
        cleanableAnimals.forEach { $0.clean() }
        continue
        }
    if let tankableAnimals = animals as? [Tankable] {
        tankableAnimals.forEach { $0.tank() }
        continue
        }
    if let cageableAnimals = animals as? [Cageable] {
        cageableAnimals.forEach { $0.cage() }
        continue
        }
    animals.forEach { $0.feed() }
}

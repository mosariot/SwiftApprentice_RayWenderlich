import Foundation

// CHAPTER CODE

enum PetKind {
    case cat
    case dog
}

struct KeeperKind {
    var keeperOf: PetKind
}

let catKeeper = KeeperKind(keeperOf: .cat)
let dogKeeper = KeeperKind(keeperOf: .dog)

enum EnumKeeperKind {
    case catKeeper
    case dogKeeper
}

class KeeperForCats {}
class KeeperForDogs {}

// generic

class Cat {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
class Dog {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

protocol Pet {
    var name: String { get }
}

extension Cat: Pet {}
extension Dog: Pet {}

class Keeper<Animal: Pet> {
    var name: String
    var morningCare: Animal
    var eveningCare: Animal
    
    init(name: String, morningCare: Animal, eveningCare: Animal) {
        self.name = name
        self.morningCare = morningCare
        self.eveningCare = eveningCare
    }
}

let jason = Keeper(name: "Jason", morningCare: Cat(name: "Whiskers"), eveningCare: Cat(name: "Sleepy"))
let anyutka = Keeper(name: "Anyutka", morningCare: Dog(name: "Sonya"), eveningCare: Dog(name: "Mishka"))
//let sasha = Keeper(name: "Sasha", morningCare: "Tuzik", eveningCare: "Pushok")

extension Array where Element: Cat {
    func meow() {
        forEach { print("\($0.name) says moew!") }
    }
}

protocol Mewoable {
    func meow()
}

extension Cat: Mewoable {
    func meow() {
        print("\(self.name) says moew!")
    }
}

extension Array: Mewoable where Element: Mewoable {
    func meow() {
        forEach { $0.meow() }
    }
}

let animalAges: Array<Int> = [2, 3, 5, 6, 8]

let intNames: Dictionary<Int, String> = [42: "forty-two"]

enum OptionalDate {
    case none
    case some(Date)
}

enum OptionalString {
    case none
    case some(String)
}

struct FormResults {
    var birthday: OptionalDate
    var lastName: OptionalString
}

enum Optional<Wrapped> {
    case none
    case some(Wrapped)
}

//var birthdate: Optional<Date> = .none
//if birthdate == .none {
//    // no birthdate
//}

var birthdateSwiftSupport: Date? = nil
if birthdateSwiftSupport == nil {
    // no birthdate
}

func swapped<T, U>(_ x: T,_ y: U) -> (U, T) {
    (y, x)
}
swapped(33, "jay")

// CHALLENGE

class SuperCat {
    var name: String

    init(name: String) {
        self.name = name
    }
}

class SuperDog {
    var name: String

    init(name: String) {
        self.name = name
    }
}

class SuperKeeper<Animal> {
    private var animalsToCare = [Animal]()
    var name: String
    var countAnimals: Int = 0
    
    func lookAfter(_ someAnimal: Animal) {
        animalsToCare.append(someAnimal)
        countAnimals += 1
    }

    init(name: String) {
        self.name = name
    }
}

let christine = SuperKeeper<SuperCat>(name: "Christine")
let someCat = SuperCat(name: "Whiskers")
let anotherCat = SuperCat(name: "Sleepy")
christine.lookAfter(someCat)
christine.lookAfter(anotherCat)
christine.countAnimals

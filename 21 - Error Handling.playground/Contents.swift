import Foundation

// CHAPTER CODE

let value = Int(3)
let failedValue = Int("nope")

enum PetFood: String {
    case kibble, canned
}

let morning = PetFood(rawValue: "kibble")
let snack = PetFood(rawValue: "fuuud!")

struct PetHouse {
    let squareFeet: Int
    
    init?(squareFeet: Int) {
        if squareFeet < 1 {
            return nil
        }
        self.squareFeet = squareFeet
    }
}

let tooSmall = PetHouse(squareFeet: 0)
let house = PetHouse(squareFeet: 1)

class PetOld {
    var breed: String?
    
    init(breed: String? = nil) {
        self.breed = breed
    }
}

class PersonOld {
    let pet: PetOld
    
    init(pet: PetOld) {
        self.pet = pet
    }
}

let delia = PetOld(breed: "pug")
let olive = PetOld()

let janieOld = PersonOld(pet: olive)
if let dogBreed = janieOld.pet.breed {
    print("Olive is a \(dogBreed)")
} else {
    print("Olive's breed is unknown")
}

class Toy {
    
    enum Kind {
        case ball
        case zombie
        case bone
        case mouse
    }
    
    enum Sound {
        case squeak
        case bell
    }
    
    let kind: Kind
    let color: String
    var sound: Sound?
    
    init(kind: Kind, color: String, sound: Sound? = nil) {
        self.kind = kind
        self.color = color
        self.sound = sound
    }
}

class Pet {
    
    enum Kind {
        case dog
        case cat
        case guineaPig
    }
    
    let name: String
    let kind: Kind
    let favoriteToy: Toy?
    
    init(name: String, kind: Kind, favoriteToy: Toy? = nil) {
        self.name = name
        self.kind = kind
        self.favoriteToy = favoriteToy
    }
}

class Person {
    let pet: Pet?
    
    init(pet: Pet? = nil) {
        self.pet = pet
    }
}

let janie = Person(pet: Pet(name: "Delia", kind: .dog, favoriteToy: Toy(kind: .ball, color: "Puple", sound: .bell)))
let tammy = Person(pet: Pet(name: "Evil Cat Overlord", kind: .cat, favoriteToy: Toy(kind: .mouse, color: "Orange")))
let felipe = Person()

if let sound = janie.pet?.favoriteToy?.sound {
    print("Sound \(sound)")
} else {
    print("No sound")
}

if let sound = tammy.pet?.favoriteToy?.sound {
    print("Sound \(sound)")
} else {
    print("No sound")
}

if let sound = felipe.pet?.favoriteToy?.sound {
    print("Sound \(sound)")
} else {
    print("No sound")
}

let team = [janie, tammy, felipe]

let petNames: () = team
        .map { $0.pet?.name }
        .forEach { print($0 as Any) }

let betterPetNames: () = team
        .compactMap { $0.pet?.name }
        .forEach { print($0) }

// ERRORS __________________________________

class Pastry {
    let flavor: String
    var numberOnHand: Int
    
    init(flavor: String, numberOnHand: Int) {
        self.flavor = flavor
        self.numberOnHand = numberOnHand
    }
}

enum BakeryError: Error {
    case tooFew(numberOnHand: Int)
    case doNotSell
    case wrongFlavor
}

class Bakery {
    var itemsForSale = [
    "Cookie": Pastry(flavor: "ChocolateChip", numberOnHand: 20),
    "PopTart": Pastry(flavor: "WildBerry", numberOnHand: 13),
    "Donut": Pastry(flavor: "Cherry", numberOnHand: 24),
    "HandPie": Pastry(flavor: "Cherry", numberOnHand: 6)
    ]
    
    func orderPastry(item: String,
                     amountRequested: Int,
                     flavor: String) throws -> Int {
        guard let pastry = itemsForSale[item] else {
            throw BakeryError.doNotSell
        }
        guard flavor == pastry.flavor else {
            throw BakeryError.wrongFlavor
        }
        guard amountRequested <= pastry.numberOnHand else {
            throw BakeryError.tooFew(numberOnHand: pastry.numberOnHand)
        }
        pastry.numberOnHand -= amountRequested
        
        return pastry.numberOnHand
    }
}

let bakery = Bakery()
do {
    try bakery.orderPastry(item: "Albatross", amountRequested: 1, flavor: "AlbatrossFalvor")
} catch BakeryError.doNotSell {
    print("Sorry, but we don't sell this item")
} catch BakeryError.wrongFlavor {
    print("Sorry, but we don't carry this flavor")
} catch BakeryError.tooFew {
    print("Sorry, we don't have enough items to fulfull your order")
}

let remaining = try? bakery.orderPastry(item: "Albatross", amountRequested: 1, flavor: "AlbatrossFlavor")

do {
    try bakery.orderPastry(item: "Cookie", amountRequested: 1, flavor: "ChocolateChip")
} catch {
    fatalError()
}
try! bakery.orderPastry(item: "Cookie", amountRequested: 1, flavor: "ChocolateChip")

// PUGBOT __________________________________

enum Direction {
    case left
    case right
    case forward
}

enum PugBotError: Error {
    case invalidMove(found: Direction, expected: Direction)
    case endOfPath
}

class PugBot {
    let name: String
    let correctPath: [Direction]
    private var currentStepInPath = 0
    
    init(name: String, correctPath: [Direction]) {
        self.name = name
        self.correctPath = correctPath
    }
    
    func move(_ direction: Direction) throws {
        guard currentStepInPath < correctPath.count else {
            throw PugBotError.endOfPath
        }
        let nextDirection = correctPath[currentStepInPath]
        guard nextDirection == direction else {
            throw PugBotError.invalidMove(found: direction, expected: nextDirection)
        }
        currentStepInPath += 1
    }
    
    func reset() {
        currentStepInPath = 0
    }
}

let pug = PugBot(name: "Pug", correctPath: [.forward, .left, .forward, .right])

func goHome() throws {
    try pug.move(.forward)
    try pug.move(.left)
    try pug.move(.forward)
    try pug.move(.right)
}

do {
    try goHome()
} catch {
    print("PugBot failed to go home")
}

func moveSafely(_ movement: () throws -> ()) -> String {
    do {
        try movement()
        return "Completed operation sucessfully"
    } catch PugBotError.invalidMove(let found, let expected) {
        return "The PugBot was supposed to move \(expected), but moved \(found) instead"
    } catch PugBotError.endOfPath {
        return "The PugBot tried to move past end of the path"
    } catch {
        return "An unkown error occured"
    }
}

pug.reset()
moveSafely(goHome)

pug.reset()
moveSafely {
    try pug.move(.forward)
    try pug.move(.left)
    try pug.move(.forward)
    try pug.move(.right)
}

func perform(times: Int, movement: () throws -> ()) rethrows {
    for _ in 1...times {
        try movement()
    }
}

// GRAND CENTRAL DISPATCH

func log(message: String) {
    let thread = Thread.current.isMainThread ? "Main" : "Background"
    print("\(thread) thread: \(message)")
}

func addNumbers(upTo range: Int) -> Int {
    log(message: "Adding numbers...")
    return (1...range).reduce(0, +)
}

let queue = DispatchQueue(label: "queue")

func execute<Result>(backgroundWork: @escaping () -> Result,
                     mainWork:       @escaping (Result) -> ()) {
    queue.async {
        let result = backgroundWork()
        DispatchQueue.main.async {
            mainWork(result)
        }
    }
}

execute(backgroundWork: { addNumbers(upTo: 100) },
        mainWork:       { log(message: "The sum is \($0)") })

// Error Handling with GCD

enum Result<Success, Failure> where Failure: Error {
    case success(Success)
    case failure(Failure)
}

struct Tutorial {
    let title: String
    let author: String
}

enum TutorialError: Error {
    case rejected
}

func feedback(for tutorial: Tutorial) -> Result<String, TutorialError> {
    Bool.random() ? .success("published") : .failure(.rejected)
}

func edit(_ tutorial: Tutorial) {
    queue.async {
        let result = feedback(for: tutorial)
        DispatchQueue.main.async {
            switch result {
            case let .success(data):
                print("\(tutorial.title) by \(tutorial.author) was \(data) on the website")
            case let .failure(error):
                print("\(tutorial.title) by \(tutorial.author) was \(error)")
            }
        }
    }
}

let tutorial = Tutorial(title: "What's new in Swift 5.1", author: "Cosmin Pupaza")
edit(tutorial)

//let result = feedback(for: tutorial)
//do {
//    let data = try result.get()
//    print("\(tutorial.title) by \(tutorial.author) was \(data) on the website")
//} catch {
//    print("\(tutorial.title) by \(tutorial.author) was \(error)")
//}

// CHALLENGES

// 1

enum StringToEvenErrors: Error {
    case notANumber
}

func StringToEven(_ string: String) throws -> Int {
    guard let double = Double(string) else {
        throw StringToEvenErrors.notANumber
    }
    let int = Int(double)
    return int - int % 2
}

do {
    try StringToEven("11.5")
} catch {
    print("Not a number!")
}

// 2

enum IntDividingErrors: Error {
    case divisonByZero
    case notDivisibleWithoutRemainder
}

func IntDividing(_ numerator: Int, by denomitator: Int) throws -> Int {
    guard denomitator != 0 else {
        throw IntDividingErrors.divisonByZero
    }
    guard (Double(numerator) / Double(denomitator) * 10).truncatingRemainder(dividingBy: 10) == 0 else {
        throw IntDividingErrors.notDivisibleWithoutRemainder
    }
    return (numerator / denomitator)
}

do {
    try IntDividing(10, by: 2)
} catch IntDividingErrors.divisonByZero {
    print("Division by Zero!")
} catch IntDividingErrors.notDivisibleWithoutRemainder {
    print("Not divisible without remainder")
}

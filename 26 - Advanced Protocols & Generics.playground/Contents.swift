import Foundation

// CHAPTER CODE

// Existential protocols

protocol Pet {
    var name: String { get }
}

struct Cat: Pet {
    var name: String
}

var somePet: Pet = Cat(name: "Whiskers")

// Non-existential protocols

protocol WeightCalculatable {
    associatedtype WeightType: Numeric
    var weigth: WeightType { get }
}

class HeavyThing: WeightCalculatable {
    typealias WeightType = Int
    
    var weigth: Int { 100 }
}

class LightThing: WeightCalculatable {
    typealias WeightType = Double
    
    var weigth: Double { 0.0025 }
}

//class StringWeightThing: WeightCalculatable {
//    typealias WeightType = String
//
//    var weigth: String {
//        "That doesn't make sense"
//    }
//}
//
//class CatWeightThing: WeightCalculatable {
//    typealias WeightType = Cat
//
//    var weigth: Cat {
//        Cat(name: "What is this cat doing here?")
//    }
//}

extension WeightCalculatable {
    static func +(left: Self, right: Self) -> WeightType {
        left.weigth + right.weigth
    }
}

var heavy1 = HeavyThing()
var heavy2 = HeavyThing()
heavy1 + heavy2

// PRODUCTION FACTORY

//protocol Product {}
//
//protocol ProductionLine {
//    func produce() -> Product
//}
//
//protocol Factory {
//    var productionLines: [ProductionLine] { get }
//}
//
//extension Factory {
//    func produce() -> [Product] {
//        var items: [Product] = []
//        productionLines.forEach { items.append($0.produce()) }
//        print("Finished Production")
//        print("-------------------")
//        return items
//    }
//}
//
//struct Car: Product {
//    init() {
//        print("Producing one awesome Car 🚔")
//    }
//}
//
//struct CarProductionLine: ProductionLine {
//    func produce() -> Product {
//        Car()
//    }
//}
//
//struct CarFactory: Factory {
//    var productionLines: [ProductionLine] = []
//}
//
//var carFactory = CarFactory()
//carFactory.productionLines = [CarProductionLine(), CarProductionLine()]
//carFactory.produce()
//
//struct Chocolate: Product {
//    init() {
//        print("Producing one chocolate bar 🍫")
//    }
//}
//
//struct ChocolateProductionLine: ProductionLine {
//    func produce() -> Product {
//        Chocolate()
//    }
//}
//
//var oddCarFactory = CarFactory()
//oddCarFactory.productionLines = [CarProductionLine(), ChocolateProductionLine()]
//oddCarFactory.produce()

protocol Product {
    init()
}

protocol ProductionLine {
    associatedtype ProductType
    func produce() -> ProductType
}

protocol Factory {
    associatedtype ProductType
    mutating func produce() -> [ProductType]
}

struct Car: Product {
    init() {
        print("Producing one awesome Car 🚔")
    }
}

struct Chocolate: Product {
    init() {
        print("Producing one chocolate bar 🍫")
    }
}

struct GenericProductionLine<P: Product>: ProductionLine {
    func produce() -> P {
        P()
    }
}

struct GenericFactory<P: Product>: Factory {
    var productionLines: [GenericProductionLine<P>] = []
    private var wareHouse: [P] = []
    
    mutating func produce() -> [P] {
        var newItems: [P] = []
        productionLines.forEach { newItems.append($0.produce()) }
        print("Finished Production")
        print("-------------------")
        wareHouse.append(contentsOf: newItems)
        return newItems
    }
    
    mutating func increaseProductionLines(by number: Int) {
        for _ in 0..<number {
            productionLines.append(GenericProductionLine<P>())
        }
    }
    
    func checkWarehouse() {
        print("\(P.self) warehouse holds \(wareHouse.count) \(wareHouse.count == 1 ? "item" : "items") of \(P.self)")
    }
}

var carFactory = GenericFactory<Car>()
carFactory.productionLines = [GenericProductionLine<Car>(), GenericProductionLine<Car>()]
carFactory.produce()

var chocolateFactory = GenericFactory<Chocolate>()
chocolateFactory.productionLines = [GenericProductionLine<Chocolate>(), GenericProductionLine<Chocolate>()]
chocolateFactory.produce()

carFactory.checkWarehouse()
carFactory.increaseProductionLines(by: 5)

carFactory.produce()
carFactory.checkWarehouse()
chocolateFactory.checkWarehouse()

// Recursive protocols

protocol GraphNode {
    var connectedNodes: [GraphNode] { get set }
}

protocol Matryoshka: AnyObject {
    var inside: Self? { get set }
}

final class HandCraftedMatryoshka: Matryoshka {
    var inside: HandCraftedMatryoshka?
}

final class MachineCraftedMatryoshka: Matryoshka {
    var inside: MachineCraftedMatryoshka?
}

var handMadeDoll = HandCraftedMatryoshka()
var machineMadeDoll = MachineCraftedMatryoshka()

handMadeDoll.inside = handMadeDoll

// Heterogeneous collections, Type erasure

class VeryHeavyThing: WeightCalculatable {
    typealias WeightType = Int
    
    var weigth: Int { 9001 }
}

//var heavyList = [HeavyThing(), VeryHeavyThing()]

class AnyHeavyThing<T: Numeric>: WeightCalculatable {
    var weigth: T { 123 }
}

class HeavyThing2: AnyHeavyThing<Int> {
    override var weigth: Int { 100 }
}

class VeryHeavyThing2: AnyHeavyThing<Int> {
    override var weigth: Int { 9001 }
}

var heavyList2 = [HeavyThing2(), VeryHeavyThing2()]
heavyList2.forEach { print($0.weigth) }

// Opaque return types

func makeFactory() -> some Factory {
    GenericFactory<Car>()
}

//func makeFactory(isChocolate: Bool) -> some Factory {
//    if isChocolate {
//        return GenericFactory<Chocolate>()
//    } else {
//        return GenericFactory<Car>()
//    }
//}

func makeFactory(numberOfLines: Int) -> some Factory {
    var factory = GenericFactory<Car>()
    for _ in 0..<numberOfLines {
        factory.productionLines.append(GenericProductionLine<Car>())
    }
    return factory
}

func makeEquatableNumeric() -> some Equatable & Numeric {
    return 1
}

let someVar = makeEquatableNumeric()
let someVar2 = makeEquatableNumeric()

print(someVar == someVar2)
print(someVar + someVar2)
//print(someVar > someVar2)

// CHALLENGES

// 1 Robot Vehicle Builder

protocol Robot {
    associatedtype itemType
    
    var piecesPerMinute: Int { get }
    var item: itemType { get }
    var totalPiecesProduced: Int { get }
    var totalItemsProduced: Int { get }
    
    mutating func produceToysFor(minutes: Double) -> String
    mutating func produceToys(number: Int) -> String
}

protocol Toy: CustomStringConvertible {
    var price: Double { get }
    var numberOfPieces: Int { get }
}

extension CustomStringConvertible where Self: Toy {
    var description: String {
        "An awesome Toy!"
    }
}

struct Truck: Toy {
    let price: Double
    let numberOfPieces: Int
}

struct ToyRobot<ToyType: Toy>: Robot {
    let piecesPerMinute: Int
    let item: ToyType
    var totalPiecesProduced: Int = 0
    var totalItemsProduced: Int = 0
    var currentItemsProduced: Int = 0
    
    mutating func produceToys(number quantity: Int) -> String {
        totalPiecesProduced += quantity * item.numberOfPieces
        totalItemsProduced += quantity
        return "Robot produced toys for \((((Double(quantity * item.numberOfPieces) / Double(piecesPerMinute))*10).rounded())/10) minutes"
    }
    
    mutating func produceToysFor(minutes: Double) -> String {
        let piecesRemainsFromLastProduction = totalPiecesProduced - (totalItemsProduced * item.numberOfPieces)
        currentItemsProduced = (Int(minutes) * piecesPerMinute + piecesRemainsFromLastProduction) / item.numberOfPieces
        totalPiecesProduced += Int(minutes) * piecesPerMinute
        totalItemsProduced += currentItemsProduced
        return "Robot produced \(currentItemsProduced) toy"
    }
    
    init(piecesPerMinute: Int, toyType: ToyType) {
        self.piecesPerMinute = piecesPerMinute
        self.item = toyType
    }
}

let truck = Truck(price: 100, numberOfPieces: 100)

var truckRobot = ToyRobot<Truck>(piecesPerMinute: 60, toyType: truck)
truckRobot.produceToys(number: 3)
truckRobot.produceToysFor(minutes: 2)
truckRobot.totalPiecesProduced
truckRobot.totalItemsProduced
truckRobot.produceToysFor(minutes: 3)


// 2 Toy train builder

struct Train: Toy {
    let price: Double
    let numberOfPieces: Int
}

func makeToyBuilder() -> some Robot {
    ToyRobot<Train>(piecesPerMinute: 500, toyType: Train(price: 100, numberOfPieces: 75))
}

makeToyBuilder()

// 3 Monster truck toy

struct MonsterTruck: Toy {
    let price: Double
    let numberOfPieces: Int
}

let monsterTruck = MonsterTruck(price: 100, numberOfPieces: 120)

func makeAnotherToyBuilder() -> some Robot {
    ToyRobot<MonsterTruck>(piecesPerMinute: 200, toyType: monsterTruck)
}

makeAnotherToyBuilder()

// 4 Shop robot

protocol Shop {
    associatedtype ItemType
    associatedtype RobotType
    
    var item: ItemType { get }
    var robot: RobotType { get }
    var display: [ItemType] { get }
    var displaySize: Int { get }
    var warehouse: [ItemType] { get }
    
    mutating func startDay(numberOfVisitors: Int)
    
}

struct ToyShop<ToyType: Toy>: Shop {
    let item: ToyType
    var robot: ToyRobot<ToyType>
    var display: [ToyType] = []
    let displaySize: Int
    var warehouse: [ToyType] = []
    var totalItemsSold: Int = 0
    private var avgCustomerPurchase: Double = 1.5
    
    mutating func startDay(numberOfVisitors: Int) {
        fillTheDisplay()
        let daySoldToys = Int((Double(numberOfVisitors) * avgCustomerPurchase))
        for _ in 0..<daySoldToys {
            sellToy()
        }
        totalItemsSold += daySoldToys
    }
    
    private mutating func fillTheDisplay() {
        for _ in 0..<(displaySize - display.count) {
            if warehouse.isEmpty {
                rentTheRobot()
            }
            moveToyFromWarehouseToDisplay()
        }
        rentTheRobot()
    }
    
    private mutating func moveToyFromWarehouseToDisplay() {
        display.append(item)
        warehouse.remove(at: warehouse.count-1)
    }
    
    private mutating func sellToy() {
        if display.isEmpty {
            fillTheDisplay()
        }
        display.remove(at: display.count-1)
    }
    
    private mutating func rentTheRobot() {
        let numberOfToysToMake = 2 * displaySize - warehouse.count
        let minutesToProduce = (((Double(numberOfToysToMake * robot.item.numberOfPieces) / Double(robot.piecesPerMinute))*10).rounded())/10
        robot.produceToysFor(minutes: minutesToProduce)
        for _ in 0..<robot.currentItemsProduced {
            warehouse.append(item)
        }
    }
    
    init(displaySize: Int, toyToSell: ToyType, toyRobotForRent: ToyRobot<ToyType>) {
        self.displaySize = displaySize
        self.item = toyToSell
        self.robot = toyRobotForRent
    }
}

var toyShop = ToyShop<Truck>(displaySize: 50, toyToSell: truck, toyRobotForRent: truckRobot)
toyShop.startDay(numberOfVisitors: 40)
toyShop.display.count
toyShop.warehouse.count
toyShop.totalItemsSold

import Foundation

// CHAPTER CODE

struct Location {
    let x: Int
    let y: Int
}
 
struct DeliveryArea: CustomStringConvertible {
    let center: Location
    let radius: Double
   
    var description: String {
        "Area with center: (x: \(center.x), y: \(center.y)), radius: \(radius)"
    }
   
    func isContains(_ location: Location) -> Bool {
        distance(from: center, to: location) < radius
    }
   
    func isOverlaps(with anotherArea: DeliveryArea) -> Bool {
        distance(from: center, to: anotherArea.center)
            <= (radius + anotherArea.radius)
    }
}

struct Pizza {
    let size: Int
    let vegetarian: Bool
    let topping: [String]
}
 
func distance(from source: Location, to target: Location) -> Double {
    let distanceX = Double(source.x - target.x)
    let distanceY = Double(source.y - target.y)
    return (distanceX * distanceX + distanceY * distanceY).squareRoot()
}
 
func isInDeliveryRange(location: Location, forArea storeArea: DeliveryArea) -> Bool {
    let deliveryDistance = distance(from: location, to: storeArea.center)
    return deliveryDistance < storeArea.radius
}
 
let storeLocation = Location(x: 2, y: 4)
let storeArea = DeliveryArea(center: storeLocation, radius: 4)
var customerLocation = Location(x: 3, y: 6)
let anotherStoreLocation = Location(x: 5, y: 8)
let anotherStoreArea = DeliveryArea(center: anotherStoreLocation, radius: 6)
 
isInDeliveryRange(location: customerLocation, forArea: storeArea)
storeArea.isContains(customerLocation)
storeArea.isOverlaps(with: anotherStoreArea)
 
// CHALLENGES
 
// 1 Fruit tree farm
 
struct Fruit {
    let type: String
    let weight: Int
}
 
var pearsContainer = [Fruit]()
var appleContainer = [Fruit]()
var orangeContainer = [Fruit]()
var totalWeightOfFruits = 0
 
let pear = Fruit(type: "pear", weight: 2)
let apple = Fruit(type: "apple", weight: 1)
let orange = Fruit(type: "orange", weight: 3)
 
let fruitTypes = [pear, apple, orange]
var truckOfFruits = [Fruit]()
let fruitsInTruck = 20
 
for _ in 1...fruitsInTruck {
    let randomIndex = Int.random(in: 0...2)
    truckOfFruits.append(fruitTypes[randomIndex])
}
 
for fruit in truckOfFruits {
    switch fruit.type {
    case "pear":
        pearsContainer.append(fruit)
    case "apple":
        appleContainer.append(fruit)
    case "orange":
        orangeContainer.append(fruit)
    default:
        break
    }
    totalWeightOfFruits += fruit.weight
}
 
print("""
    Count of pears: \(pearsContainer.count), apples: \(appleContainer.count), oranges: \(orangeContainer.count).
    Total weight of fruits: \(totalWeightOfFruits)
    """)
 
// 2 A T-Shirt Model
 
enum Size {
    case XS, S, M, L, XL
    var priceFactor: Double {
        switch self {
            case .XS: return 0.8
            case .S: return 0.9
            case .M: return 1.0
            case .L: return 1.1
            case .XL: return 1.2
        }
    }
}
 
enum Color {
    case grey, black, white, blue, green, purple, red
    var priceFactor: Double {
        switch self {
            case .grey, .black, .white: return 0.9
            case .blue, .green, .purple: return 1.0
            case .red: return 1.1
        }
    }
}
 
enum Material {
    case cotton, elastane, linen, polyester, viscose
    var priceFactor: Double {
        switch self {
            case .cotton: return 0.9
            case .linen, .polyester, .viscose: return 1.0
            case .elastane: return 1.1
        }
    }
}
 
struct TShirt {
    let size: Size
    let color: Color
    let material: Material
    let basePrice: Double = 1000
   
    var price: Double {
        basePrice * size.priceFactor * color.priceFactor * material.priceFactor
    }
}
 
let tShirt = TShirt(size: .L, color: .red, material: .linen)
tShirt.price

// 3 Battleship

struct BattleLocation {
    let x: Int
    let y: Int
}
 
enum Direction {
    case up, down, right, left
}
 
enum Lenght: Int {
    case one = 1, two = 2, three = 3, four = 4
}
 
var gameDesk = [Int: [Int: Bool]]()
 
func createDesk() {
    for i in 1...10 {
        gameDesk[i] = [:]
        for j in 1...10 {
            gameDesk[i]?[j] = false
        }
    }
}
 
struct Ship {
    let originLocation: (Int, Int)
    let direction: Direction
    let lenght: Lenght
 
    func setShip() {
        switch direction {
        case .up:
        for i in 0...lenght.rawValue-1 {
            gameDesk[originLocation.0]?[originLocation.1 + i] = true
        }
        case .down:
        for i in 0...lenght.rawValue-1 {
            gameDesk[originLocation.0]?[originLocation.1 - i] = true
        }
        case .right:
        for i in 0...lenght.rawValue-1 {
            gameDesk[originLocation.0 + i]?[originLocation.1] = true
        }
        case .left:
        for i in 0...lenght.rawValue-1 {
            gameDesk[originLocation.0 - i]?[originLocation.1] = true
        }
        }
    }
   
    func isSuccessfulSet() -> Bool {
        switch direction {
        case .up:
        for i in 0...lenght.rawValue-1 {
            if gameDesk[originLocation.0]?[originLocation.1 + i] == true {
                return false
            }
        }
        case .down:
        for i in 0...lenght.rawValue-1 {
            if gameDesk[originLocation.0]?[originLocation.1 - i] == true {
                return false
            }
        }
        case .right:
        for i in 0...lenght.rawValue-1 {
            if gameDesk[originLocation.0 + i]?[originLocation.1] == true {
                return false
            }
        }
        case .left:
        for i in 0...lenght.rawValue-1 {
            if gameDesk[originLocation.0 - i]?[originLocation.1] == true {
                return false
            }
        }
        }
        return true
    }
   
    func shot(to location: BattleLocation) -> Void {
        if gameDesk[location.x]?[location.y] == true {
            print("Hit!")
        } else {
            print("You missed!")
        }
    }
   
    init?(originLocation: (Int, Int), direction: Direction, lenght: Lenght) {
        self.originLocation = originLocation
        self.direction = direction
        self.lenght = lenght
        if !(originLocation.0 > 0 && originLocation.0 <= 10 && originLocation.1 > 0 && originLocation.1 <= 10) ||
            ((direction == .up && (originLocation.1 + lenght.rawValue-1) > 10 ) ||
            (direction == .down && (originLocation.1 - lenght.rawValue-1) < 0) ||
            (direction == .right && originLocation.0 + lenght.rawValue-1 > 10) ||
            (direction == .left && (originLocation.0 - lenght.rawValue-1) < 0)) ||
            !isSuccessfulSet()
            {
            print("Корабль не может быть установлен")
            return nil
        }
        self.setShip()
    }
}

createDesk()
let enemyShip = Ship(originLocation: (5, 5), direction: .left, lenght: .four)
let anotherShip = Ship(originLocation: (5, 5), direction: .right, lenght: .three)
let shotLocation = BattleLocation(x: 3, y: 5)
enemyShip?.shot(to: shotLocation)

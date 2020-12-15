import Foundation

// CHAPTER CODE

extension String {
    func shout() {
        print(uppercased())
    }
}

"Swift is pretty cool!".shout()

protocol TeamRecord {
    var wins: Int { get }
    var losses: Int { get }
    var winningPercentage: Double { get }
}

extension TeamRecord {
    var gamesPlayed: Int {
        wins + losses
    }
}

extension TeamRecord {
    var winningPercentage: Double {
        Double(wins) / Double(wins + losses)
    }
}

struct BaseballRecord: TeamRecord {
    var wins: Int
    var losses: Int
}

let sanFranciscoSwifts = BaseballRecord(wins: 10, losses: 5)
sanFranciscoSwifts.gamesPlayed

struct BasketballRecord: TeamRecord {
    var wins: Int
    var losses: Int
    let seasonLenght = 82
}

let minneapolisFunctors = BasketballRecord(wins: 60, losses: 22)
minneapolisFunctors.winningPercentage

struct HockeyRecord: TeamRecord {
    var wins: Int
    var losses: Int
    var ties: Int
    
    var winningPercentage: Double {
        Double(wins) / Double(wins + ties + losses)
    }
}

let chicagoOptionals = BasketballRecord(wins: 10, losses: 6)
let phoenixStridables = HockeyRecord(wins: 8, losses: 7, ties: 1)

chicagoOptionals.winningPercentage
phoenixStridables.winningPercentage

extension CustomStringConvertible {
    var description: String {
        "Remember to implement CustomStringConvertible!"
    }
}

struct MyStruct: CustomStringConvertible {}
print(MyStruct())

// static dispatch

protocol WinLoss {
    var wins: Int { get }
    var losses: Int { get }
//    var winningPercentage: Double { get } // превращает static dispatch в dynamic dispatch
}

extension WinLoss {
    var winningPercentage: Double {
        Double(wins) / Double(wins + losses)
    }
}

struct CricketRecord: WinLoss {
    var wins: Int
    var losses: Int
    var draws: Int
    
    var winningPercentage: Double {
        Double(wins) / Double(wins + losses + draws)
    }
}

let miamiTuples = CricketRecord(wins: 8, losses: 7, draws: 1)
let winLoss: WinLoss = miamiTuples

miamiTuples.winningPercentage
winLoss.winningPercentage

// type constraints

protocol PostSeasonEligible {
    var minimumWinsForPlayoffs: Int { get }
}

extension TeamRecord where Self: PostSeasonEligible {
    var isPlayoffEligible: Bool {
        wins > minimumWinsForPlayoffs
    }
}

protocol Tieable {
    var ties: Int { get }
}

extension TeamRecord where Self: Tieable {
    var winningPercentage: Double {
        Double(wins) / Double(wins + losses + ties)
    }
}

struct RugbyRecord: TeamRecord, Tieable {
    var wins: Int
    var losses: Int
    var ties: Int
}

let rugbyRecord = RugbyRecord(wins: 8, losses: 7, ties: 1)
rugbyRecord.winningPercentage

// mini-exercise

extension CustomStringConvertible where Self: TeamRecord {
    var description: String {
        "\(wins) - \(losses)"
    }
}
extension RugbyRecord: CustomStringConvertible {}

print(rugbyRecord)

// programming interfaces not implementations (в примерах показано неудобство применения реализации, а не протоколов)

class TeamRecordBase {
    var wins = 0
    var losses = 0
    
    var winningPercentage: Double {
        Double(wins) / Double(wins + losses)
    }
}

class HockeyRecord_1: TeamRecordBase {
    var ties = 0
    
    override var winningPercentage: Double {
        Double(wins) / Double(wins + losses + ties)
    }
}

class TieableRecordBase: TeamRecordBase {
    var ties = 0
    
    override var winningPercentage: Double {
        Double(wins) / Double(wins + losses + ties)
    }
}

class HockeyRecord_2: TieableRecordBase { }
class CricketRecord_: TieableRecordBase { }

extension TieableRecordBase {
    var totalPoints: Int {
        (2 * wins) + (1 * ties)
    }
}

// traits, mixins, multiple inheritance

protocol TieableRecord {
    var ties: Int { get }
}

protocol DivisionalRecord {
    var divisionalWins: Int { get }
    var divisionalLosses: Int { get }
}

protocol ScorableRecord {
    var totalPoints: Int { get }
}

extension ScorableRecord where Self: TieableRecord, Self: TeamRecord {
    var totalPoints: Int {
        (2 * wins) + (1 * ties)
    }
}

struct SuperHockeyRecord: TeamRecord, TieableRecord, DivisionalRecord, CustomStringConvertible, Equatable {
    var wins: Int
    var losses: Int
    var ties: Int
    var divisionalWins: Int
    var divisionalLosses: Int
    
    var description: String {
        "\(wins) - \(ties)"
    }
}

let hockey1 = SuperHockeyRecord(wins: 5, losses: 5, ties: 5, divisionalWins: 5, divisionalLosses: 5)
let hockey2 = SuperHockeyRecord(wins: 5, losses: 5, ties: 5, divisionalWins: 5, divisionalLosses: 5)
hockey1 == hockey2

// CHALLENGES

// 1


protocol Item: CustomStringConvertible {
    var name: String { get }
    var clearance: Bool { get }
    var msrp: Double { get }
    var totalPrice: Double { get }
}

protocol Taxable: Item { }

protocol Discountable: Item {
    var discountOnClearance: Double { get }
}

protocol Expirable: Item {
    var expirationDate: String { get }
}

extension Item {
    var totalPrice: Double {
        msrp
    }
}

extension Taxable {
    var saleTax: Double { 0.075 }
}

extension Item where Self: Discountable {
    var totalPrice: Double {
        clearance ? msrp * (1 - discountOnClearance) : msrp
    }
}

extension Item where Self: Taxable {
    var totalPrice: Double {
        msrp * (1 + saleTax)
    }
}

extension Item where Self: Discountable & Taxable {
    var totalPrice: Double {
        clearance ? msrp * (1 + saleTax) * (1 - discountOnClearance) : msrp * (1 + saleTax)
    }
}

extension CustomStringConvertible where Self: Item {
    var description: String {
        "\(name)"
    }
}

extension CustomStringConvertible where Self: Expirable {
    var description: String {
        "\(name), \(expirationDate)"
    }
}

struct Food: Discountable, Taxable, Expirable {
    let name: String
    var clearance: Bool
    var msrp: Double
    let expirationDate: String
    let discountOnClearance = 0.5
}

struct Clothes: Discountable {
    let name: String
    var clearance: Bool
    var msrp: Double
    let discountOnClearance = 0.25
}


struct Electronics: Discountable, Taxable {
    let name: String
    var clearance: Bool
    var msrp: Double
    let discountOnClearance = 0.05
}

var food = Food(name: "Apple", clearance: true, msrp: 100, expirationDate: "01.06.20")
food.totalPrice
food

var clothes = Clothes(name: "Shirt", clearance: true, msrp: 150)
clothes.totalPrice
clothes

var electronics = Electronics(name: "MacBook", clearance: true, msrp: 1000)
electronics.totalPrice
electronics

// RW //
//protocol Item: CustomStringConvertible {
//    var name: String { get }
//    var clearance: Bool { get }
//    var msrp: Double { get }
//    var totalPrice: Double { get }
//}
//
//protocol Taxable: Item {
//    var taxPercentage: Double { get }
//}
//
//protocol Discountable: Item {
//    var adjustedMsrp: Double { get }
//}
//
//extension Item {
//    var description: String {
//        name
//    }
//}
//
//extension Item {
//    var totalPrice: Double {
//        msrp
//    }
//}
//
//extension Item where Self: Taxable {
//    var totalPrice: Double {
//        msrp * (1 + taxPercentage)
//    }
//}
//
//extension Item where Self: Discountable {
//    var totalPrice: Double {
//        adjustedMsrp
//    }
//}
//
//extension Item where Self: Taxable & Discountable {
//    var totalPrice: Double {
//        adjustedMsrp * (1 + taxPercentage)
//    }
//}
//
//struct Clothing: Discountable {
//    let name: String
//    var msrp: Double
//    var clearance: Bool
//
//    var adjustedMsrp: Double {
//        msrp * (clearance ? 0.75 : 1.0)
//    }
//}
//
//struct Electronics: Taxable, Discountable {
//    let name: String
//    var msrp: Double
//    var clearance: Bool
//
//    let taxPercentage = 0.075
//
//    var adjustedMsrp: Double {
//        msrp * (clearance ? 0.95 : 1.0)
//    }
//}
//
//struct Food: Taxable {
//    let name: String
//    var msrp: Double
//    var clearance: Bool
//    let expirationDate: (month: Int, year: Int)
//
//    let taxPercentage = 0.075
//
//    var adjustedMsrp: Double {
//        msrp * (clearance ? 0.50 : 1.0)
//    }
//
//    var description: String {
//        "\(name) - expires \(expirationDate.month)/\(expirationDate.year)"
//    }
//}
//
//Food(name: "Bread", msrp: 2.99, clearance: false, expirationDate: (11, 2016)).totalPrice
//Clothing(name: "Shirt", msrp: 12.99, clearance: true).totalPrice
//Electronics(name: "Apple TV", msrp: 139.99, clearance: false).totalPrice
//
//Food(name: "Bread", msrp: 2.99, clearance: false, expirationDate: (11, 2016))
//Clothing(name: "Shirt", msrp: 12.99, clearance: true)

// 2 Doubling values

extension Sequence where Element: Numeric {
    func double() -> [Element] {
        map { $0 * 2 }
    }
}

let int = [1, 2, 3, 4]
let double = [1.5, 2.5, 3.5, 4.5]
let string = ["a", "b", "c", "d"]

int.double()
double.double()


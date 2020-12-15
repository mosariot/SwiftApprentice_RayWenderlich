import Foundation

public protocol Account {
    associatedtype Currency
    
    var balance: Currency { get }
    func deposit(amount: Currency)
    func withdraw(amount: Currency)
}

public typealias Dollars = Double

open class BasicAccount: Account {
    
    public private(set) var balance: Dollars = 0.0
    
    public init() {}
    
    public func deposit(amount: Dollars) {
        balance += amount
    }
    
    public func withdraw(amount: Double) {
        if amount <= balance {
            balance -= amount
        } else {
            balance = 0
        }
    }
}

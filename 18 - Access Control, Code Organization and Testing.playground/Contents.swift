import Foundation
import XCTest

// CHAPTER CODE

class SavingsAccount: BasicAccount {
    var interestRate: Double
    private let pin: Int?
    
    init(interestRate: Double, pin: Int) {
        self.interestRate = interestRate
        self.pin = pin
    }
    
    @available(*, deprecated, message: "Use init(interestRate:pin:) instead")
    init(interestRate: Double) {
        self.interestRate = interestRate
        self.pin = nil
    }
    
    func processInterest(pin: Int) {
        if pin == self.pin {
            let interest = balance * interestRate
            deposit(amount: interest)
        }
    }
    
    @available(*, deprecated, message: "Use processInterest(pin:) instead")
    func processInterest() {
        let interest = balance * interestRate
        deposit(amount: interest)
    }
}

let account = BasicAccount()

account.deposit(amount: 10.00)
account.withdraw(amount: 5.00)

let johnChecking = CheckingAccount()
johnChecking.deposit(amount: 300.00)

let check = johnChecking.writeCheck(amount: 200.00)!

let janeChecking = CheckingAccount()
janeChecking.deposit(check)
janeChecking.balance
johnChecking.balance
janeChecking.deposit(check)
janeChecking.balance
check.account
print(janeChecking)

var person = Person(firstName: "Tim", lastName: "Kovalev")
print(person.fullName)

class Doctor: ClassyPerson {
    override var fullName: String {
        "Dr." + " " + firstName + " " + lastName
    }
}

let doctor = Doctor(firstName: "Alex", lastName: "Vorobiev")
print(doctor.fullName)

// opaque return types
func createAccountSome() -> some Account {
    CheckingAccount()
}
let checkingAccountSome = createAccountSome()
createAccountSome()

func createAccountGeneric<T: Account>() -> T {
    CheckingAccount() as! T
}
let checkingAccountGeneric: CheckingAccount = createAccountGeneric()

let sAccount = SavingsAccount(interestRate: 1.05, pin: 5)
sAccount.deposit(amount: 100)
sAccount.processInterest(pin: 5)
sAccount.balance

// testing

class BankingTests: XCTestCase {
    var checkingAccount: CheckingAccount!
    
    override func setUp() {
        super.setUp()
        checkingAccount = CheckingAccount()
    }
    
    override func tearDown() {
        checkingAccount.withdraw(amount: checkingAccount.balance)
        super.tearDown()
    }
    
    func testNewAccountBalanceZero() {
        XCTAssertEqual(checkingAccount.balance, 0)
    }
    
    func testCheckOverBudgetFails() {
        let check = checkingAccount.writeCheck(amount: 100)
        XCTAssertNil(check)
    }
}

BankingTests.defaultTestSuite.run()

// CHALLENGES

// 1

public class Logger {
    
    private init() {}
    
    static let sharedInstance = Logger()
    
    func log(_ text: String) {
        print(text)
    }
}

Logger.sharedInstance.log("Hello, Swift!")

// 2

struct Stack<T> {
    private var stack: [T] = []
    
    func peek() -> T? {
        guard stack.count > 0 else {
            return nil
        }
        return stack.last
    }
    
    mutating func push(_ element: T) {
        stack.append(element)
    }
    
    mutating func pop() -> T? {
        guard stack.count > 0 else {
            return nil
        }
        return stack.remove(at: stack.count-1)
    }
    
    func count() -> Int {
        stack.count
    }
}

var stack = Stack<Int>()
stack.peek()
stack.pop()
stack.push(15)
stack.push(25)
stack.push(45)
stack.push(5)
stack.peek()
stack.pop()
stack.peek()
stack.count()

// 3

let elf = GameCharacterFactory.make(ofType: .elf)
let giant = GameCharacterFactory.make(ofType: .giant)
let wizard = GameCharacterFactory.make(ofType: .wizard)

battle(elf, vs: giant)
battle(wizard, vs: giant)
battle(wizard, vs: elf)

import Foundation

// CHAPTER CODE

class Tutorial {
    let title: String
    unowned let author: Author
    weak var editor: Editor?
    lazy var description: () -> String = {
        [weak self] in
        guard let self = self else {
            return "The tutorial is no longer available."
        }
            return "\(self.title) by \(self.author.name)" }
    
    init(title: String, author: Author) {
        self.title = title
        self.author = author
    }
    
    deinit {
        print("Goodbye tutorial \(title)!")
    }
}

class Author {
    let name: String
    var tutorials: [Tutorial] = []
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Goodbye author \(name)!")
    }
}

class Editor {
    let name: String
    var tutorials: [Tutorial] = []
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Goodbye editor \(name)!")
    }
}

do {
    let author = Author(name: "Cosmin")
    let tutorial = Tutorial(title: "Memory Management", author: author)
    print(tutorial.description())
    let editor = Editor(name: "Ray")
    author.tutorials.append(tutorial)
    tutorial.editor = editor
    editor.tutorials.append(tutorial)
}

let tutorialDescription: () -> String
do {
    let author = Author(name: "Cosmin")
    let tutorial = Tutorial(title: "Memory Management", author: author)
    tutorialDescription = tutorial.description
}
print(tutorialDescription())

var counter = 0
var f = { [counter] in print(counter) }
counter = 1
f()

// CHALLENGES

// 1

class Person {
    let name: String
    let email: String
    weak var car: Car?
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
    
    deinit {
        print("Goodbye \(name)!")
    }
}

class Car {
    let id: Int
    let type: String
    var owner: Person?
    
    init(id: Int, type: String) {
        self.id = id
        self.type = type
    }
    
    deinit {
        print("Goodbye \(type)!")
    }
}

var owner: Person? = Person(name: "Cosmin", email: "cosmin@whatever.com")
var car: Car? = Car(id: 10, type: "BMW")

owner?.car = car
car?.owner = owner

owner = nil
car = nil

// 2

class Customer {
    let name: String
    let email: String
    var account: Account?
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
    
    deinit {
        print("Goodbye \(name)!")
    }
}

class Account {
    let number: Int
    let type: String
    unowned let customer: Customer
    
    init(number: Int, type: String, customer: Customer) {
        self.number = number
        self.type = type
        self.customer = customer
    }
    
    deinit {
        print("Goodbye \(type) account number \(number)!")
    }
}

var customer: Customer? = Customer(name: "George", email: "george@whatever.com")
var account: Account? = Account(number: 10, type: "PayPal", customer: customer!)

customer?.account = account

account = nil
customer = nil

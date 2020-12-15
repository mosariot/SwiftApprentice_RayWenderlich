import Foundation

// CHAPTER CODE

class Person {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}

let john = Person(firstName: "Johnny", lastName: "Appleseed")
john.firstName = "John"
var homeOwner = john
homeOwner.lastName = "Vorobiev"
homeOwner.fullName
john.fullName

homeOwner === john

let imposterJohn = Person(firstName: "Johh", lastName: "Vorobiev")
imposterJohn === john

homeOwner = imposterJohn
homeOwner === john

homeOwner = john
homeOwner === john

var imposters = (0...100).map { _ in
    Person(firstName: "John", lastName: "Vorobiev")
}

imposters.contains {
    $0.firstName == john.firstName && $0.lastName == john.lastName
}

imposters.contains {
    $0 === john
}
imposters.insert(john, at: Int.random(in: 0..<100))
imposters.contains {
    $0 === john
}

if let indexOfJohn = imposters.firstIndex(where:
                                            { $0 === john }) {
    imposters[indexOfJohn].lastName = "Bananapeel"
}
john.fullName

func isPersonMemberOf(person: Person, ofGroup group: [Person]) -> Bool {
    return group.contains { $0 === person }
}
let firstNames = ["Andrey", "Alexander", "Nikolay", "Dmitriy", "Martha"]
let lastNames = ["Panin", "Sobko", "Shestakov", "Oleynik", "Lushnikova"]
let firstGroup = (0...4).map {i in
        Person(firstName: firstNames[i], lastName: lastNames[i])
    }
var secondGroup = firstGroup
secondGroup[3] = john
 
isPersonMemberOf(person: john, ofGroup: firstGroup)
isPersonMemberOf(person: john, ofGroup: secondGroup)
 
struct Grade {
    let letter: String
    let points: Double
    let credits: Double
}
 
class Student {
    var firstName: String
    var lastName: String
    var grades: [Grade] = []
    var credits = 0.0
   
    var gpa: Double {
        guard grades.count > 0 else { return 0 }
        var pointsAve = 0.0
        var creditsAve = 0.0
        for grade in grades {
            pointsAve += grade.points
            creditsAve += grade.credits
        }
        return pointsAve / creditsAve
    }
   
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
   
    func recordGrade(_ grade: Grade) {
        grades.append(grade)
        // ошибочное прибавление в случае обновления одного из предметов Grade
        credits += grade.credits
    }
}
 
let jane = Student(firstName: "Jane", lastName: "Appleseed")
let history = Grade(letter: "B", points: 9.0, credits: 3.0)
var math = Grade(letter: "A", points: 16.0, credits: 4.0)
 
jane.recordGrade(history)
jane.recordGrade(math)
jane.gpa
 
jane.credits
math = Grade(letter: "A", points: 20.0, credits: 5.0)
jane.recordGrade(math)
jane.credits
 
extension Student {
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}

// CHALLENGES

// 1
 
class List {
    let name: String
    var movieList: [String]
   
    init(name: String, movieList: [String]) {
        self.name = name
        self.movieList = movieList
    }
   
    func printList() {
        movieList.forEach { print($0) }
    }
}
 
class User {
    var lists = [String: List]()
   
    func addList(_ listToAdd: List) {
        lists[listToAdd.name] = listToAdd
    }
   
    func list(_ forName: String) -> List? {
        lists[forName]
    }
}
 
let janeMovie = User()
let johnMovie = User()
 
let comedyList = List(name: "Comedies", movieList: ["Dumb and Dumber", "Liar, Liar", "Ace Ventura"])
let dramaList = List(name: "Dramas", movieList: ["Saving Private Ryan", "Schindler's List", "Forrest Gump"])
let adventureList = List(name: "Adventures", movieList: ["Пираты XX века", "The Lord of The Rings", "Hobbit"])
 
janeMovie.addList(comedyList)
janeMovie.addList(dramaList)
janeMovie.addList(adventureList)
 
johnMovie.addList(comedyList)
johnMovie.addList(dramaList)
johnMovie.addList(adventureList)
 
johnMovie.lists["Comedies"]?.movieList = ["Кавказская пленница", "Операция Ы и другие приключения Шурика"]
johnMovie.list("Comedies")?.printList()
janeMovie.list("Comedies")?.printList()
 
// 2
 
struct TShirt {
    let size: String
    let color: String
    let price: Int
    let image: String?
}
 
struct Address {
    let name: String
    let street: String
    let city: String
    let zipCode: Int
}
 
class ShoppingCart {
    var order: [TShirt] = []
    let address: Address
   
    init(address: Address) {
        self.address = address
    }
   
    func totalCost() -> Int {
        order.reduce(0) { $0 + $1.price }
    }
}
 
class Customer {
    let name: String
    let email: String
    let shoppingCart: ShoppingCart?
   
    init(name: String, email: String) {
        self.name = name
        self.email = email
        shoppingCart = nil
    }
}

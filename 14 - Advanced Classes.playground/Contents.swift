import Foundation

// CHAPTER CODE

struct Grade {
    var letter: Character
    var points: Double
    var credits: Double
}
 
class Person {
    var firstName: String
    var lastName: String
 
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    deinit {
        print("\(firstName) \(lastName) Person (superclass) is being removed from memory!")
    }
}
 
class Student: Person {
    var grades: [Grade] = []
    var graduateList: [Student] = []
    weak var partner: Student?
    
    func recordGrade(_ grade: Grade) {
        grades.append(grade)
    }
    
    deinit {
        graduateList.append(self)
        print("\(self.firstName) \(self.lastName) Student (subclass) is removed from memory.")
        graduateList.forEach {
            print("\($0.firstName) \($0.lastName) - выполнение деинициализатора")
        }
    }
}
 
let john = Person(firstName: "Johnny", lastName: "Appleseed")
let jane = Student(firstName: "Jane", lastName: "Appleseed")
 
let history = Grade(letter: "B", points: 9.0, credits: 3.0)
jane.recordGrade(history)
 
class BandMember: Student {
    var minimumPracticeTime = 2
}
 
class OboePlayer: BandMember {
    override var minimumPracticeTime: Int {
        get {
            return super.minimumPracticeTime * 2
        }
        set {
            super.minimumPracticeTime = newValue / 2
        }
    }
}
 
// polymorphism
 
func phonebookName(_ person: Person) -> String {
    "\(person.lastName), \(person.firstName)"
}
 
let person = Person(firstName: "John", lastName: "Appleseed")
let oboePlayer = OboePlayer(firstName: "Jane", lastName: "Appleseed")
 
phonebookName(person)
phonebookName(oboePlayer)

// runtime hierarchy checks
 
var hallMonitor = Student(firstName: "Jill", lastName: "Appleseed")
hallMonitor = oboePlayer
 
// (oboePlayer as Student).minimumPracticeTime
(hallMonitor as? BandMember)?.minimumPracticeTime
(hallMonitor as! BandMember).minimumPracticeTime
 
if let hallMonitor = hallMonitor as? BandMember {
    print("This hall monitor is a band member and practices at least \(hallMonitor.minimumPracticeTime) hours per week")
}
 
func afterClassActivity(for student: Student) -> String {
    return "Goes home!"
}
func afterClassActivity(for student: BandMember) -> String {
    return "Goes to practice!"
}

afterClassActivity(for: oboePlayer)
afterClassActivity(for: oboePlayer as Student)

// inheritance, super, initializers

class StudentAthlete: Student {
    var sports: [String]
    var failedClasses: [Grade] = []
    
    init(firstName: String, lastName: String, sports: [String]) {
        // phase 1 initialization (define all the subclass properties)
        self.sports = sports
        let passGrade = Grade(letter: "P", points: 0.0, credits: 0.0)
        // phase 2 initialization (after it we can call methods)
        super.init(firstName: firstName, lastName: lastName)
        recordGrade(passGrade)
    }
    
    override func recordGrade(_ grade: Grade) {
        super.recordGrade(grade)
        
        if grade.letter == "F" {
            failedClasses.append(grade)
        }
    }
    
    var isEligible: Bool {
        failedClasses.count < 3
    }
}

// final

final class FinalStudent: Person {}

class AnotherStudent: Person {
    final func recordGrade(_ grade: Grade) {}
}

// required, convinience init

class NewStudent {
    let firstName: String
    let lastName: String
    var grades: [Grade] = []
    
    required init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init(transfer: Student) {
        self.firstName = transfer.firstName
        self.lastName = transfer.firstName
    }
    
    convenience init(someStudent: Student) {
        self.init(firstName: someStudent.firstName, lastName: someStudent.lastName)
    }
}

class NewStudentAthlete: NewStudent {
    var sports: [String]
    
    required init(firstName: String, lastName: String) {
        self.sports = []
        super.init(firstName: firstName, lastName: lastName)
    }
}

// when to subclass

class Team {
    var players: [StudentAthlete] = []
    
    var isEligible: Bool {
        for player in players {
            if !player.isEligible {
                return false
            }
        }
        return true
    }
}

class Button {
    func press() {}
}

class Image {}

class ImageButton: Button {
    var image: Image
    
    init(image: Image) {
        self.image = image
    }
}

class TextButton: Button {
    var text: String
    
    init(text: String) {
        self.text = text
    }
}

// class lifecycle, ARC

var someone = Person(firstName: "Johhny", lastName: "Appleseed")
var anotherSomeone: Person? = someone
var lotsOfPeople = [someone, someone, anotherSomeone, someone]
anotherSomeone = nil
lotsOfPeople = []
someone = Person(firstName: "John", lastName: "Appleseed")

var alice: Student? = Student(firstName: "Alice", lastName: "Appleseed")
var bob: Student? = Student(firstName: "Bob", lastName: "Appleseed")
alice?.partner = bob
bob?.partner = alice

alice = nil
bob = nil

// CHALLENGES

// 1

class A {
    init() {
        print("I'm <A>!")
    }
    
    deinit {
        print("<A> deinit")
    }
}
class B: A {
    override init() {
        print("I'm <B>!")
        super.init()
        print("I'm <B>!")
    }
    
    deinit {
        print("<B> deinit")
    }
}
class C: B {
    override init() {
        print("I'm <C>!")
        super.init()
        print("I'm <C>!")
    }
    
    deinit {
        print("<C> deinit")
    }
}

var c: C? = C()
let a = c! as A
c = nil

// 4

class StudentBaseballPlayer: StudentAthlete {
    let position: String
    let number: Int
    var battingAverage: Double
    
    init(firstName: String, lastName: String, sports: [String], position: String, number: Int, battingAverage: Double) {
        self.position = position
        self.number = number
        self.battingAverage = battingAverage
        super.init(firstName: firstName, lastName: lastName, sports: sports)
    }
}

let studentBaseballPlayer = StudentBaseballPlayer(firstName: "Alex", lastName: "Vorobiev", sports: ["Baseball"], position: "Defence", number: 3, battingAverage: 34)

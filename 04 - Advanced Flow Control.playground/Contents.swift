import Foundation

// FOR LOOPS
// MINI-EXERCISES
// 1
let range = 1...10
for i in range {
    print(i*i)
}
 
// 2
for i in range {
    print(sqrt(Double(i)))
}
 
// 3
var sum = 0
for row in 0..<8 where row % 2 != 0 {
    for column in 0..<8 {
        sum += row * column
    }
}
sum

// SWITCH
// MINI-EXERCISES
// 1
let age = 15
var lifeStage = ""
switch age {
    case 0...2:
    lifeStage = "Infant"
    case 3...12:
    lifeStage = "Child"
    case 13...19:
    lifeStage = "Teenager"
    case 20...39:
    lifeStage = "Adult"
    case 40...60:
    lifeStage = "Middle aged"
    case 61...:
    lifeStage = "Elderly"
    default:
    print("Not valid Age")
}
lifeStage
 
// 2
let humanData = ("Matt", 30)
var humanDescription = ""
switch humanData {
    case let (name, 0...2):
    humanDescription = "\(name) is an infant"
    case let (name, 3...12):
    humanDescription = "\(name) is an child"
    case let (name, 13...19):
    humanDescription = "\(name) is an teenager"
    case let (name, 20...39):
    humanDescription = "\(name) is an adult"
    case let (name, 40...60):
    humanDescription = "\(name) is an middle aged"
    case let (name, 61...):
    humanDescription = "\(name) is an elderly"
    default:
    humanDescription = "Not valid Age"
}
print(humanDescription)

// CHALLENGES

// 5
var counterTo0 = 10
for i in 0...10 {
    print(i+counterTo0)
    counterTo0 -= 2
}
 
// 6
for i in 0...10 {
    print(Double(i)/10)
}

import Foundation

// MINI-EXERCISES

// 1
let myAge: Int = 38

// 2
var averageAge: Double = 38
averageAge = (38 + 30) / 2

// 3
let testNumber = 34
let evenOdd = testNumber % 2

// 4
var answer = 0
answer += 1
answer += 10
answer *= 10
answer << 3

// CHALLENGES

// 1
var dogs: Int = 0
dogs += 1

// 2
var age: Int = 16
print(age)
age = 30
print(age)

// 3
let x: Int = 46
let y: Int = 10
let answer1: Int = (x * 100) + y
let answer2: Int = (x * 100) + (y * 100)
let answer3: Int = (x * 100) + (y / 10)

// 4
8 - (4 * 2) + ((6 / 3) * 4)

// 5
let rating1: Double = 45
let rating2: Double = 36
let rating3: Double = 16
let averageRating = (rating1 + rating2 + rating3) / 3

// 6
let voltage: Double = 220
let current: Double = 1.5
let power: Double = voltage * current

// 7
let resistance: Double = power / (current * current)

// 8
let randomNumber = arc4random()
let diceRoll = arc4random() % 5 + 1
let altRandom = Int.random(in: 1...6)

// 9
let a: Double = 5
let b: Double = 23
let c: Double = 24
let root1: Double = (-b + sqrt(b*b - 4*a*c)) / (2*a)
let root2: Double = (-b - sqrt(b*b - 4*a*c)) / (2*a)

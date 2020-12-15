import Foundation

// COMPARISON OPERATORS
// MINI-EXERCISES
// 1
let myAge = 38
let isTeenager = myAge <= 19 && myAge >= 13
// 2
let theirAge = 30
let bothTeenagers = myAge <= 19 && theirAge <= 19 && myAge >= 13 && theirAge >= 13
// 3
let reader = "Alex Vorobiev"
let author = "Matt Galloway"
let authorIsReader = reader == author
// 4
let readerBeforeAuthor = reader < author

// IF STATEMENT
// MINI-EXERCISES
// 1
if myAge >= 13 && myAge <= 19 {
    print("Teenager")
} else {
    print("Not a teenager")
}
// 2
let answer = myAge >= 13 && myAge <= 19 ? "Teenager" : "Not a teenager"
print(answer)

// LOOPS
// MINI-EXERCISES
// 1
var counter = 0
while counter < 10 {
    print("counter is \(counter)")
    counter += 1
}
// 2
var newCounter = 0
var roll = 0
repeat {
    roll = Int.random(in: 0...5)
    newCounter += 1
    print("After \(newCounter) rolls, roll is \(roll)")
} while roll != 0

// CHALLENGES

// 3
let currentPosition = 2
let diceRoll = 5
let nextPosition: Int
if (currentPosition + diceRoll) == 3 {
    nextPosition = 15
} else if (currentPosition + diceRoll) == 7 {
    nextPosition = 12
} else if (currentPosition + diceRoll) == 11 {
    nextPosition = 2
} else if (currentPosition + diceRoll) == 17 {
    nextPosition = 9
} else {
    nextPosition = (currentPosition + diceRoll)
}
nextPosition

// 4
let month = "february"
let year = 2020
var numberOfDays: Int = 0
if month == "january" || month == "march" || month == "may" || month == "july" || month == "august" || month == "october" || month == "december" {
    numberOfDays = 31
} else if month == "april" || month == "june" || month == "september" || month == "november" {
    numberOfDays = 30
} else if month == "february" && ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
    numberOfDays = 29
}
numberOfDays

// 5
let number = 50
var powerOfTwo: Int = 0
var resultOfPower = 1
while resultOfPower <= number {
    resultOfPower *= 2
    powerOfTwo += 1
}
powerOfTwo

// 6
let depthForTriangularNumber = 5
let triangularNumber = depthForTriangularNumber * (depthForTriangularNumber + 1)

// 7
let fibonacciNumber = 10
var fibonacci = 1
var fibonacciMinusOne = 1
var fibonacciMinusTwo = 1
 
if fibonacciNumber > 2 {
    var counter = 2
    while counter < fibonacciNumber {
        fibonacci = fibonacciMinusOne + fibonacciMinusTwo
        fibonacciMinusTwo = fibonacciMinusOne
        fibonacciMinusOne = fibonacci
        counter += 1
    }
}
fibonacci

// 8
let factor = 4
var counter12 = 1
while counter12 <= 12 {
    print("\(factor) * \(counter12) = \(factor * counter12)")
    counter12 += 1
}

// 9
var rollResult = 2
while rollResult <= 12 {
    var combinations = 0
    var firstDice = 1
    while firstDice <= 6 {
        var secondDice = 1
        while secondDice <= 6 {
            if firstDice + secondDice == rollResult {
                combinations += 1
            }
            secondDice += 1
        }
        firstDice += 1
    }
    print("\(rollResult) - \(combinations)")
    rollResult += 1
}

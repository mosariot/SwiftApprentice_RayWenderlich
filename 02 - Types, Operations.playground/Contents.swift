import Foundation

// TYPE CONVERSION
// MINI-EXERCISES
// 1
let age1 = 42
let age2 = 21
// 2
let avg1 = (age1 + age2) / 2
// 3
let avg2 = (Double(age1) + Double(age2)) / 2

// STRINGS
// MINI-EXERCISES
// 1
let firstName = "Alex"
let lastName = "Vorobiev"
// 2
let fullName = firstName + " " + lastName
// 3
let myDetails = "Hello, my name is \(fullName)"

// TUPLES
// MINI-EXERCISES
// 1
var datePlusTemp: (month: Int, day: Int, year: Int, averageTemperature: Double)
datePlusTemp = (3, 1, 2020, 2.5)
// 3
let (_, day, _, avgTemp) = datePlusTemp
// 4
datePlusTemp.averageTemperature = 4.5

// CHALLENGES

// 1
let coordinate = (2, 3)

// 2
let namedCoordinate = (row: 2, column: 3)

// 4
let tuple = (day: 15, month: 8, year: 2015)
let someDay = tuple.day

// 5
var name = "Matt"
name += " Galloway"

// 6
let tuple2 = (100, 1.5, 10)
let value = tuple2.1

// 7
let tuple3 = (day: 15, month: 8, year: 2015)
let month = tuple3.month

// 8
let number = 10
let multiplier = 5
let summary = "\(number) multiplied by \(multiplier) equals \(number * multiplier)"

// 9
let a = 4
let b: Int32 = 100
let c: UInt8 = 12
let sum = a + Int(b) - Int(c)

// 10
Double.pi - Double(Float.pi)


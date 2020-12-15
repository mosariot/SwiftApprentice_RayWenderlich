import Foundation

// MINI-EXERCISES

// 1
let names = ["Alexandr", "Anna", "Timofey", "Leo"]
names.reduce("", +)
// 2
names
    .filter { $0.count > 4 }
    .reduce("", +)
// 3
let namesAndAges = ["Alexandr": 38, "Anna": 33, "Timofey": 9, "Leo": 3]
namesAndAges.filter { $0.value < 18 }
// 4
namesAndAges
    .filter { $0.value > 18 }
    .map { $0.key }

// CHALLENGES

// 1
func repeatTask(times: Int, task: () -> Void) {
    for _ in 1...times {
        task()
    }
}
repeatTask(times: 10) { print("Swift Apperntice is a great book") }
 
// 2
func mathSum(lenght: Int, series: (Int) ->  Int) -> Int {
    var sum = 0
    for i in 1...lenght {
        sum += series(i)
    }
    return sum
}
print(mathSum(lenght: 10) { $0 * $0 })

func fibbonacci(_ number: Int) -> Int {
    if number == 1 || number == 2 { return 1 }
    return fibbonacci(number - 1) + fibbonacci(number - 2)
}
print(mathSum(lenght: 10) { fibbonacci($0) })
 
// 3
var appRatings = [
    "Calendar Pro": [1, 5, 5, 4, 2, 1, 5, 4],
    "The Messenger": [5, 4, 2, 5, 4, 1, 1, 2],
    "Socialise": [2, 1, 2, 2, 1, 2, 4, 2]
]
var averageRatings = [String: Double]()
appRatings.forEach { averageRatings[$0.key] = ($0.value.reduce(0) { (Double($0) + Double($1)) } / Double($0.value.count)) }
averageRatings
averageRatings
    .filter { $0.value > 3 }
    .map { $0.key }

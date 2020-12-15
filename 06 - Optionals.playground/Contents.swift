import Foundation

// CHALLENGES

// 2
func divideIfWhole(_ value: Int, by divisor: Int) -> Int? {
    if value % divisor == 0 {
        return value / divisor
    } else {
        return nil
    }
}
if let divisionResult = divideIfWhole(10, by: 3) {
    print("Yep, it divides \(divisionResult) times")
} else {
    print("Not divisible :[.")
}

// 3
let divisionIfWholeResult = divideIfWhole(15, by: 5)
print("It divides \(divisionIfWholeResult ?? 0) times")

// 4
let number: Int??? = nil
if let firstUnwrap = number {
    if let secondUnwrap = firstUnwrap {
        if let thirdUnwrap = secondUnwrap {
            print(thirdUnwrap)
        }
    }
}

import Foundation

// MINI-EXERCISES

// 1
func printFullName(firstName: String, lastName: String) {
    print(firstName + " " + lastName)
}
printFullName(firstName: "Alex", lastName: "Vorobiev")
 
// 2
func printFullName(_ firstName: String, _ lastName: String) {
    print(firstName + " " + lastName)
}
printFullName("Andrey", "Panin")
 
// 3
func calculateFullName(firstName: String, lastName: String) -> String {
    return firstName + " " + lastName
}
let myName = calculateFullName(firstName: "Alex", lastName: "Vorobiev")
 
// 4
func calculateFullName(_ firstName: String, _ lastName: String) -> (String, Int) {
    let fullName = firstName + " " + lastName
    return (fullName, fullName.count)
}
calculateFullName("Alex", "Vorobiev")
 
// CHALLENGES
 
// 1
for index in stride(from: 10, through: 9.0, by: -0.1) {
    print(index)
}
 
// 2
func isNumberDivisible(_ number: Int, by divisor: Int) -> Bool {
    if number <= 0 {
        return false
    }
    if number % divisor == 0 {
        return true
    } else {
        return false
    }
}
 
func isPrime(_ number: Int) -> Bool {
    for i in 2...Int(sqrt(Float(number))) {
        if isNumberDivisible(number, by: i) == true {
            return false
        } else {
            continue
        }
    }
    return true
}
isPrime(6)
isPrime(13)
isPrime(8893)

// 3
func fibonacci(_ number: Int) -> Int {
    if number == 1 || number == 2 {
        return 1
    } else {
        return fibonacci(number - 1) + fibonacci(number - 2)
    }
}

fibonacci(1)
fibonacci(2)
fibonacci(3)
fibonacci(4)
fibonacci(5)
fibonacci(10)

import Foundation

// MINI-EXERCISES

// arrays
var players = ["Alice", "Bob", "Dan", "Eli", "Frank"]
players.firstIndex(of: "Dan")

players = ["Anna", "Brian", "Craig", "Dan", "Donna", "Eli", "Franklin"]
let scores = [2, 2, 8, 6, 1, 2, 1]
for i in 0...players.count-1 {
    print("\(players[i]) - \(scores[i])")
}

// dictionaries
var bobData = [
    "name": "Bob",
    "profession": "Card Player",
    "country": "USA",
    "state": "CA",
    "city": "San Francisco"]
func getCityAndState(for person: [String: String]) {
    print("\(person["name"]!) is living in \(person["city"]!), \(person["state"]!)")
}
getCityAndState(for: bobData)

// CHALLENGES

// 2
var arrayToRemove = [5, 6, 7, 3, 7, 9, 20, 6, 26]
func removingOnce(_ item: Int, from array: inout [Int]) -> [Int] {
    guard let indexOfItem = array.firstIndex(of: item) else { return array }
    array.remove(at: indexOfItem)
    return array
}
removingOnce(7, from: &arrayToRemove)

// 3
func removing(_ item: Int, from array: inout [Int]) -> [Int] {
    while array.firstIndex(of: item) != nil {
        array.remove(at: array.firstIndex(of: item)!)
    }
    return array
}
removing(6, from: &arrayToRemove)

// 4
let arrayToWorkWith = [1, 2, 3, 4, 5, 6]
func reversed(_ array: [Int]) -> [Int] {
    var reversedArray = [Int]()
    for item in array {
        reversedArray.insert(item, at: 0)
    }
    return reversedArray
}
reversed(arrayToWorkWith)
 
// 5
func middle(_ array: [Int]) -> Int? {
    guard array.count != 0 else { return nil }
    var middleIndex = 0
    if array.count % 2 != 0 {
        middleIndex = array.count / 2
    } else {
        middleIndex = array.count / 2 - 1
    }
    return array[middleIndex]
}
middle(arrayToWorkWith) as Any
 
// 6
func minMax(of numbers: [Int]) -> (min: Int, max: Int)? {
    guard numbers.count != 0 else { return nil }
    var min = numbers.first!
    var max = numbers.first!
    for number in numbers {
        if number < min {
            min = number
        }
        if number > max {
            max = number
        }
    }
    return (min, max)
}
minMax(of: arrayToWorkWith) as Any
 
// 8
let states = ["NY": "New York", "CA": "California", "NJ": "New Jersey"]
func longNamedStates(_ stateDict: [String: String]) -> Void {
    for stateName in stateDict.values {
        if stateName.count > 8 {
            print(stateName)
        }
    }
}
longNamedStates(states)
 
// 9
let firstDict = ["1": "A", "2": "E", "3": "C"]
let secondDict = ["4": "D", "2": "B", "6": "F"]
func merging(_ dict1: [String: String], with dict2: [String: String]) -> [String: String] {
    var mergeResult = dict1
    for (key, value) in dict2 {
        mergeResult[key] = value
    }
    return mergeResult
}
merging(firstDict, with: secondDict)
 
// 10
let stringToAnalize = "Hello, i am a beginner in Swift"
func occurenceOfCharacters(in text: String) -> [Character: Int] {
    var resultDict = [Character: Int]()
    for char in text {
        if resultDict[char] != nil {
            resultDict[char]! += 1
        } else {
            resultDict[char] = 1
        }
    }
    return resultDict
}
occurenceOfCharacters(in: stringToAnalize)
 
// 11
let dictionaryForTest = ["One": 1, "Two": 2, "Three": 3, "Four": 4]
func isInvertible(_ dictionary: [String: Int]) -> Bool {
    var arrayValues = [Int]()
    for value in dictionary.values {
        arrayValues.append(value)
    }
    if arrayValues.count == Set(arrayValues).count {
        return true
    } else {
        return false
    }
}
isInvertible(dictionaryForTest)
 
// 12
var nameTitleLookup: [String: String?] = ["Mary": "Engineer", "Patrick": "Intern", "Ray": "Hacker"]
nameTitleLookup.updateValue(nil, forKey: "Patrick")
nameTitleLookup["Ray"] = nil
nameTitleLookup

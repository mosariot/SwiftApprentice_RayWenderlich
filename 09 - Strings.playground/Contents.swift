import Foundation
 
// CHALLENGES
 
// 1
let stringToAnalize = "Programming - it's a very exciting activity. That's my opinion."
func occurenceOfCharacters(in text: String) -> Void {
    var resultDict = [Character: Int]()
    for char in text {
        if resultDict[char] != nil {
            resultDict[char]! += 1
        } else {
            resultDict[char] = 1
        }
    }
    let sortedDict = resultDict
        .sorted(by: { $0.key < $1.key } )
        .sorted(by: { $0.value < $1.value } )
    sortedDict.forEach {
        var graphicCount = ""
        for _ in 1...$0.value {
            graphicCount += "#"
        }
        print("\($0.key) - \(graphicCount)")
    }
}
occurenceOfCharacters(in: stringToAnalize)
 
// 2
func howManyWords(in text: String) -> Void {
    var wordsCount = 0
    var previousChar = text[text.startIndex]
    let aToZLowercase = "a"..."z"
    let aToZCapital = "A"..."Z"
    text.forEach {
        if $0.isWhitespace &&
          (aToZLowercase.contains(String(previousChar)) || aToZCapital.contains(String(previousChar)) ||
          String(previousChar) == ".") {
                wordsCount += 1
        }
        previousChar = $0
    }
    print("В строке - \(wordsCount + 1) слов")
}
howManyWords(in: stringToAnalize)
 
3
let unformattedName = "Vorobiev, Alexandr"
func formattedName(of name: String) -> String {
    guard let spaceIndex = name.firstIndex(of: " ") else { return "Not valid format of Name" }
    return String(name[name.index(after: spaceIndex)...]) + " " + String(name[..<name.index(before: spaceIndex)])
}
formattedName(of: unformattedName)
 
// 4
let stringToSeparate = "Andrey,Alexandr,Dmitriy,Nikolay,Marta"
func componentsByUser(of text: String, separatedBy separator: String) -> [String] {
    var resultArray = [String]()
    var previousSeparatorIndex = text.startIndex
    for currentIndex in text.indices {
        if text[currentIndex] == Character(separator) {
            var nextName = String(text[previousSeparatorIndex..<currentIndex])
            if nextName.contains(",") {
                nextName.remove(at: nextName.startIndex)
            }
            resultArray.append(nextName)
            previousSeparatorIndex = currentIndex
        }
    }
    return resultArray
}
componentsByUser(of: stringToSeparate, separatedBy: ",")

// 5
let stringToReverse = "Как твои дела, начинающий программист?"
func everyWordReversed(of text: String) -> String {
    var reversedWordsString = ""
    var previousSeparatorIndex = text.startIndex
    for currentIndex in text.indices {
        if text[currentIndex].isWhitespace {
            let nextWord = String(text[previousSeparatorIndex...currentIndex])
            reversedWordsString += nextWord.reversed()
            previousSeparatorIndex = currentIndex
        }
    }
    let lastWord = String(text[previousSeparatorIndex...text.index(before: text.endIndex)]).reversed()
    reversedWordsString += lastWord
    if reversedWordsString[reversedWordsString.startIndex].isWhitespace {
        reversedWordsString.remove(at: reversedWordsString.startIndex)
    }
    return reversedWordsString
}
everyWordReversed(of: stringToReverse)

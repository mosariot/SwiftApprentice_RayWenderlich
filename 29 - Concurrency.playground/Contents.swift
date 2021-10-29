import UIKit
import Foundation

// CHAPTER CODE

let task = Task {
    print("Doing some work on a task")
    let sum = (1...100).reduce(0, +)
    try Task.checkCancellation()
    print("1 + 2 + 3 ... 100 = \(sum)")
}
print("Doing some work on the main actor")
task.cancel()

func helloPauseGoodbye() async throws {
    print("Hello")
    try await Task.sleep(nanoseconds: 1_000_000_000)
    print("Goodbye")
}

Task {
    try await helloPauseGoodbye()
}

// Decoding an API

struct Domains: Decodable {
    let data: [Domain]
}

struct Domain: Decodable {
    let attributes: Attributes
}

struct Attributes: Decodable {
    let name: String
    let description: String
    let level: String
}

func fetchDomains() async throws -> [Domain] {
    let url = URL(string: "https://api.raywenderlich.com/api/domains")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode(Domains.self, from: data).data
}

Task {
    do {
        let domains = try await fetchDomains()
        for domain in domains {
            let attr = domain.attributes
            print("\(attr.name): \(attr.description) - \(attr.level)")
        }
    } catch {
        print(error)
    }
}

// Asynchronous sequences

func findTitle(url: URL) async throws -> String? {
    for try await line in url.lines {
        if line.contains("<title>") {
            return line.trimmingCharacters(in: .whitespaces)
        }
    }
    return nil
}

Task {
    if let title = try await findTitle(url: URL(string: "https://www.raywenderlich.com")!) {
        print(title)
    }
}

// Unstructered concurrency

func findTitlesSerial(first: URL, second: URL) async throws -> (String?, String?) {
  let title1 = try await findTitle(url: first)
  let title2 = try await findTitle(url: second)
  return (title1, title2)
}

// Structured concurrency

//func findTitlesParallel(first: URL, second: URL) async throws -> (String?, String?) {
//    async let title1 = findTitle(url: first)
//    async let title2 = findTitle(url: second)
//    let titles = try await [title1, title2]
//    return (titles[0], titles[1])
//}

// Async properties and subscripts

extension Domains {
    static var domains: [Domain] {
        get async throws {
            try await fetchDomains()
        }
    }
}

Task {
    dump(try await Domains.domains)
}

extension Domains {
    enum Error: Swift.Error { case outOfRange }
    
    static subscript(_ index: Int) -> String {
        get async throws {
            let domains = try await Self.domains
            guard domains.indices.contains(index) else {
                throw Error.outOfRange
            }
            return domains[index].attributes.name
        }
    }
}

Task {
    dump(try await Domains[4])
}

// Actors

// CHALLENGES

// 1

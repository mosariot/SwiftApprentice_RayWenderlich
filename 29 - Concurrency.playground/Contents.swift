import UIKit

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

class Playlist {
    
    let title: String
    let author: String
    private(set) var songs: [String]
    
    init(title: String, author: String, songs: [String]) {
        self.title = title
        self.author = author
        self.songs = songs
    }
    
    func add(song: String) {
        songs.append(song)
    }
    
    func remove(song: String) {
        guard !songs.isEmpty, let index = songs.firstIndex(of: song) else { return }
        songs.remove(at: index)
    }
    
    func move(song: String, from playlist: Playlist) {
        playlist.remove(song: song)
        add(song: song)
    }
    
    func move(song: String, to playlist: Playlist) {
        playlist.add(song: song)
        remove(song: song)
    }
}

// convert to actor ->

actor PlaylistActor {

    let title: String
    let author: String
    private(set) var songs: [String]

    init(title: String, author: String, songs: [String]) {
        self.title = title
        self.author = author
        self.songs = songs
    }

    func add(song: String) {
        songs.append(song)
    }

    func remove(song: String) {
        guard !songs.isEmpty, let index = songs.firstIndex(of: song) else { return }
        songs.remove(at: index)
    }

    func move(song: String, from playlist: PlaylistActor) async {
        await playlist.remove(song: song)
        add(song: song)
    }

    func move(song: String, to playlist: PlaylistActor) async {
        await playlist.add(song: song)
        remove(song: song)
    }
}

extension PlaylistActor: CustomStringConvertible {
    nonisolated var description: String {
        "\(title) by \(author)."
    }
}

let favorites = PlaylistActor(title: "Favorite songs", author: "Cosmin", songs: ["Nothing else matters"])
let partyPlaylist = PlaylistActor(title: "Party songs", author: "Ray", songs: ["Stairway to heaven"])
Task {
    await favorites.move(song: "Stairway to heaven", from: partyPlaylist)
    await favorites.move(song: "Nothing else matters", to: partyPlaylist)
    await print(favorites.songs)
}

print(favorites)

// Sendable

final class BasicPlaylist {
    let title: String
    let author: String
    
    init(title: String, author: String) {
        self.title = title
        self.author = author
    }
}

extension BasicPlaylist: Sendable {}

func execute(task: @escaping @Sendable () -> Void, with priority: TaskPriority? = nil) {
    Task(priority: priority, operation: task)
}

@Sendable func showRandomNumber() {
    let number = Int.random(in: 1...10)
    print(number)
}

execute(task: showRandomNumber)

// CHALLENGES

// 1 Safe teams

actor Team {
  let name: String
  let stadium: String
  private var players: [String]
  
  init(name: String, stadium: String, players: [String]) {
    self.name = name
    self.stadium = stadium
    self.players = players
  }
  
  private func add(player: String) {
    players.append(player)
  }
  
  private func remove(player: String) {
    guard !players.isEmpty, let index = players.firstIndex(of: player) else {
      return
    }
    players.remove(at: index)
  }
  
  func buy(player: String, from team: Team) async {
    await team.remove(player: player)
    add(player: player)
  }
  
  func sell(player: String, to team: Team) async {
    await team.add(player: player)
    remove(player: player)
  }
}

// 2 Custom teams

extension Team: CustomStringConvertible {
    nonisolated var description: String {
        "\(name) on \(stadium)."
    }
}

// 3 Sendable teams

final class BasicTeam {
  let name: String
  let stadium: String
  
  init(name: String, stadium: String) {
    self.name = name
    self.stadium = stadium
  }
}

extension BasicTeam: Sendable {}

import Foundation
import XCTest

// CHAPTER CODE

struct Employee {
    var name: String
    var id: Int
    var favoriteToy: Toy?
    
    enum CodingKeys: String, CodingKey {
        case id = "employeeID"
        case name
        case gift
    }
}

extension Employee: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(favoriteToy?.name, forKey: .gift)
    }
}

extension Employee: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        id = try values.decode(Int.self, forKey: .id)
        if let gift = try values.decodeIfPresent(String.self, forKey: .gift) {
            favoriteToy = Toy(name: gift)
        }
    }
}

struct Toy: Codable {
    var name: String
}

let toy1 = Toy(name: "Teddy Bear")
let employee1 = Employee(name: "John Appleseed", id: 7, favoriteToy: toy1)

let jsonEncoder = JSONEncoder()
let jsonData = try jsonEncoder.encode(employee1)
print(jsonData)

let jsonString = String(data: jsonData, encoding: .utf8)!
print(jsonString)

let jsonDecoder = JSONDecoder()
let employee2 = try jsonDecoder.decode(Employee.self, from: jsonData)

class EncoderDecoderTests: XCTestCase {
    var jsonEncoder: JSONEncoder!
    var jsonDecoder: JSONDecoder!
    var toy1: Toy!
    var employee1: Employee!
    
    override func setUp() {
        super.setUp()
        jsonEncoder = JSONEncoder()
        jsonDecoder = JSONDecoder()
        toy1 = Toy(name: "Teddy Bear")
        employee1 = Employee(name: "Johnny Appleseed", id: 7, favoriteToy: toy1)
    }
    
    func testEncoder() {
        let jsonData = try? jsonEncoder.encode(employee1)
        XCTAssertNotNil(jsonData, "Encoding failed")
        
        let jsonString = String(data: jsonData!, encoding: .utf8)!
        XCTAssertEqual(jsonString, "{\"name\":\"Johnny Appleseed\",\"employeeID\":7,\"gift\":\"Teddy Bear\"}")
    }
    
    func testDecoder() {
        let jsonData = try! jsonEncoder.encode(employee1)
        let employee2 = try? jsonDecoder.decode(Employee.self, from: jsonData)
        XCTAssertNotNil(employee2, "Decoding failed")
        
        XCTAssertEqual(employee1.name, employee2!.name)
        XCTAssertEqual(employee1.id, employee2!.id)
        XCTAssertEqual(employee1.favoriteToy?.name, employee2!.favoriteToy?.name)
    }
}

EncoderDecoderTests.defaultTestSuite.run()

// CHALLENGES

// 1, 2, 3

struct SpaceShip: Codable {
    var name: String
    var crew: [Spaceman?]
    
    enum CodingKeys: String, CodingKey {
        case name = "spaceship_name"
        case crew
    }
}

extension SpaceShip {
    enum CrewKeys: String, CodingKey {
        case captain
        case officer
    }
}

extension SpaceShip {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        let crewValues = try decoder.container(keyedBy: CrewKeys.self)
        let captain = try crewValues.decodeIfPresent(Spaceman.self, forKey: .captain)
        let officer = try crewValues.decodeIfPresent(Spaceman.self, forKey: .officer)
        crew = [captain, officer]
    }
}

struct Spaceman: Codable {
    var name: String
    var race: String
}

let spaceShip1 = SpaceShip(name: "TestSpaceShipName", crew: [Spaceman(name: "TestFirstName", race: "TestRace")])
let spaceJson = try jsonEncoder.encode(spaceShip1)
let spaceString = String(data: spaceJson, encoding: .utf8)!
print(spaceString)

let incoming = "{\"spaceship_name\":\"USS Enterprise\", \"captain\":{\"name\":\"Spock\", \"race\":\"Human\"}, \"officer\":{\"name\": \"Worf\", \"race\":\"Klingon\"}}"
let earthSpaceShip = try jsonDecoder.decode(SpaceShip.self, from: incoming.data(using: .utf8)!)
earthSpaceShip.name
earthSpaceShip.crew

// 4

var klingonSpaceship = SpaceShip(name: "IKS NEGH'VAR", crew: [])
let klingonMessage = try PropertyListEncoder().encode(klingonSpaceship)
let klingonSpaceShipDecoded = try PropertyListDecoder().decode(SpaceShip.self, from: klingonMessage)
klingonSpaceShipDecoded.name
klingonSpaceShipDecoded.crew

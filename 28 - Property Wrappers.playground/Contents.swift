import UIKit

// CHAPTER CODE

struct Colour {
    @ZeroToOne var red: Double
    @ZeroToOne var green: Double
    @ZeroToOne var blue: Double
}

// Classic Property Wrapper

@propertyWrapper
struct ZeroToOne {
    
    private var value: Double
    
    private static func clamped(_ input: Double) -> Double {
        min(max(input, 0), 1)
    }
    
    init(wrappedValue: Double) {
        value = Self.clamped(wrappedValue)
    }
    
    var wrappedValue: Double {
        get { value }
        set { value = Self.clamped(newValue) }
    }
}

var superRed = Colour(red: 2, green: 0, blue: 0)
print(superRed)

superRed.blue = -2
print(superRed)

func printValue(@ZeroToOne _ value: Double) {
    print("The wrapped value is", value)
}

printValue(3.14)

// Projected Value

@propertyWrapper
struct ZeroToOneV2 {
    
    private var value: Double
    
    init(wrappedValue: Double) {
        value = wrappedValue
    }
    
    var wrappedValue: Double {
        get { min(max(value, 0),1) }
        set { value = newValue }
    }
    
    var projectedValue: Double { value }
}

func printValueV2(@ZeroToOneV2 _ value: Double) {
    print("The wrapped value is", value)
    print("The projected value is", $value)
}

printValueV2(3.14)

// With Parameters

@propertyWrapper
struct ZeroTo {
    
    private var value: Double
    let upper: Double
    
    init(wrappedValue: Double, upper: Double) {
        value = wrappedValue
        self.upper = upper
    }
    
    var wrappedValue: Double {
        get { min(max(value,0), upper)}
        set { value = newValue}
    }
    
    var projectedValue: Double { value }
}

func printValueV3(@ZeroTo(upper: 10) _ value: Double) {
    print("The wrapped value is", value)
    print("The projected value is", $value)
}

printValueV3(42)

// Generic

@propertyWrapper
struct ZeroToV2<Value: Numeric & Comparable> {
    
    private var value: Value
    let upper: Value
    
    init(wrappedValue: Value, upper: Value) {
        value = wrappedValue
        self.upper = upper
    }
    
    var wrappedValue: Value {
        get { min(max(value, 0), upper)}
        set { value = newValue}
    }
    
    var projectedValue: Value { value }
}

func printValueV4(@ZeroToV2(upper: 10) _ value: Int) {
    print("The wrapped value is", value)
    print("The projected value is", $value)
}

printValueV4(42)

// CopyOnWrite Implementation

struct Color: CustomStringConvertible {
    var red, green, blue: Double
    
    var description: String {
        "r: \(red) g: \(green) b: \(blue)"
    }
}

extension Color {
    static var black = Color(red: 0, green: 0, blue: 0)
    static var white = Color(red: 1, green: 1, blue: 1)
    static var blue = Color(red: 0, green: 0, blue: 1)
    static var green = Color(red:0, green: 1, blue: 0)
}

class Bucket {
    var color: Color
    
    init(color: Color) {
        self.color = color
    }
}

@propertyWrapper
struct CopyOnWriteColor {
    
    private var bucket: Bucket
    
    init(wrappedValue: Color) {
        self.bucket = Bucket(color: wrappedValue)
    }
    
    var wrappedValue: Color {
        get { bucket.color }
        set {
            if isKnownUniquelyReferenced(&bucket) {
                bucket.color = newValue
            } else {
                bucket = Bucket(color: newValue)
            }
        }
    }
}

struct PaintingPlan {
    
    var accent = Color.white
    
    @CopyOnWriteColor var bucketColor = .blue
    @CopyOnWriteColor var bucketColorForDoor = .blue
    @CopyOnWriteColor var bucketColorForWalls = .blue
}

// Projected Values Usage

@propertyWrapper
public struct ValidatedDate {
    
    private var storage: Date? = nil
    private (set) var formatter = DateFormatter()
    
    public init(wrappedValue: String) {
        self.formatter.dateFormat = "yyyy-mm-dd"
        self.wrappedValue = wrappedValue
    }
    
    public var wrappedValue: String {
        set {
            self.storage = formatter.date(from: newValue)
        }
        
        get {
            if let date = self.storage {
                return formatter.string(from: date)
            } else {
                return "invalid"
            }
        }
    }
    
    public var projectedValue: DateFormatter {
        get { formatter }
        set { formatter = newValue }
    }
}

struct Order {
    @ValidatedDate var orderPlacedDate: String = ""
    @ValidatedDate var shipping: String = ""
    @ValidatedDate var deliveredDate: String = ""
}

var order = Order()
order.orderPlacedDate = "2014-06-02"
order.orderPlacedDate

let otherFormatter = DateFormatter()
otherFormatter.dateFormat = "mm/dd/yyyy"
order.$orderPlacedDate = otherFormatter

order.orderPlacedDate

// CHALLENGES

// 1 

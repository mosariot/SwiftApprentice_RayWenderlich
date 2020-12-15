import UIKit

// CHAPTER CODE

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
    var isRefilled = false
    
    init(color: Color) {
        self.color = color
    }
    
    func refill() {
        isRefilled = true
    }
}

let azurePaint = Bucket(color: .blue)
let wallBluePaint = azurePaint
wallBluePaint.isRefilled
azurePaint.refill()
wallBluePaint.isRefilled

extension Color {
    mutating func darken() {
        red *= 0.9; green *= 0.9; blue *= 0.9
    }
}

var azure = Color.blue
var wallBlue = azure
azure
wallBlue.darken()
azure

// value types containing mutable reference types

struct PaintingPlan {
    var accent = Color.white
    
    @CopyOnWriteColor var bucketColor = .blue
    @CopyOnWriteColor var bucketColorForDoor = .blue
    @CopyOnWriteColor var bucketColorForWalls = .blue
//    private var bucket = Bucket(color: .blue)
//
//    var bucketColor: Color {
//        get {
//            bucket.color
//        }
//        set {
//            if isKnownUniquelyReferenced(&bucket) {
//                bucket.color = bucketColor
//            } else {
//                bucket = Bucket(color: newValue)
//            }
//        }
//    }
}

@propertyWrapper
    struct CopyOnWriteColor {
        
        init(wrappedValue: Color) {
            self.bucket = Bucket(color: wrappedValue)
        }
        
        private var bucket: Bucket
        
        var wrappedValue: Color {
            get {
                bucket.color
            }
            set {
                if isKnownUniquelyReferenced(&bucket) {
                    bucket.color = newValue
                } else {
                    bucket = Bucket(color: newValue)
                }
            }
        }
    }

var artPlan = PaintingPlan()
var housePlan = artPlan
artPlan.bucketColor
housePlan.bucketColor = .green
housePlan.bucketColor
artPlan.bucketColor

// 1 Image with value semantics

private class Pixels {
    let storageBuffer: UnsafeMutableBufferPointer<UInt8>
    
    init(size: Int, value: UInt8) {
        let p = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
        storageBuffer = UnsafeMutableBufferPointer<UInt8>(start: p, count: size)
        storageBuffer.initialize(from: repeatElement(value, count: size))
    }
    
    init(pixels: Pixels) {
        let otherStorage = pixels.storageBuffer
        let p = UnsafeMutablePointer<UInt8>.allocate(capacity: otherStorage.count)
        storageBuffer = UnsafeMutableBufferPointer<UInt8>(start: p, count: otherStorage.count)
        storageBuffer.initialize(from: otherStorage)
    }
    
    subscript(offset: Int) -> UInt8 {
        get {
            storageBuffer[offset]
        }
        set {
            storageBuffer[offset] = newValue
        }
    }
    
    deinit {
        storageBuffer.baseAddress!.deallocate()
    }
}

struct Image {
    let width, height: Int
    var value: UInt8
    
    private var image: [Pixels] = []
    
    init(width: Int, height: Int, value: UInt8) {
        self.width = width
        self.height = height
        self.value = value
        
        for _ in 1...height {
            image.append(Pixels(size: width, value: value))
        }
    }
    
    subscript(row: Int, column: Int) -> UInt8 {
        get {
            image[row][column]
        }
        set {
            if isKnownUniquelyReferenced(&image[row]) {
                image[row][column] = newValue
            } else {
                let tempImageRow = image[row] // запоминаем ссылку на старую строку
                image[row] = Pixels(size: width, value: value) // инициализируем новую строку для текущего image - copy-on-write
                for currentColumn in 0...width-1 { // назначаем новой скопированной строке всю информацию из старой общей для всех строки (по ссылке)
                    image[row][currentColumn] = tempImageRow[currentColumn]
                }
                image[row][column] = newValue
            }
        }
    }
    
    mutating func clear(with value: UInt8) {
        image = [] // создает новый пустой экзепляр (не по ссылке) - copy-on-write
        for _ in 1...height {
            image.append(Pixels(size: width, value: value))
        }
    }
}
var image1 = Image(width: 4, height: 4, value: 0)

image1[0,0] // 0
image1[0,0] = 100
image1[0,1] = 50
image1[0,1] // 50
image1[1,1] = 5
image1[0,0] // 100
image1[1,1] // 5
image1[0,1] // 50

var image2 = image1
image2[0,0] // 100
image2[0,1] // 50
image2[0,1] = 150
image2[0,1] // 150
image1[0,1] // 50
image2[1,1] // 5
image2[0,0] = 200
image2[0,0] // 200
image1[0,0] // 100
image1[0,0] = 2
image1[0,0] // 2
image2[0,0] // 200
image1[0,1] = 60
image1[0,1] // 60
image2[0,1] // 150

var image3 = image2
image3.clear(with: 255)
image3[0,0] // 255
image2[0,0] // 200
image2[1,1] // 5
image1[0,0] // 2
image1[0,1] // 60
image2[0,1] // 150
image1[1,1] // 5

struct ImageRW {
    private (set) var width: Int
    private (set) var height: Int
    private var pixels: Pixels
    private var mutatingPixels: Pixels {
        mutating get {
            if !isKnownUniquelyReferenced(&pixels) {
                pixels = Pixels(pixels: pixels)
            }
            return pixels
        }
    }
    
    init(width: Int, height: Int, value: UInt8) {
        self.width = width
        self.height = height
        self.pixels = Pixels(size: width * height, value: value)
    }
    
    subscript(x: Int, y: Int) -> UInt8 {
        get {
            pixels[y * width + x]
        }
        set {
            mutatingPixels[y * width + x] = newValue
        }
    }
    
    mutating func clear(with value: UInt8) {
        for (i, _) in mutatingPixels.storageBuffer.enumerated() {
            mutatingPixels.storageBuffer[i] = value
        }
    }
}

var image1RW = ImageRW(width: 4, height: 4, value: 0)

image1RW[0,0] // 0
image1RW[0,0] = 100
image1RW[0,1] = 50
image1RW[0,1] // 50
image1RW[1,1] = 5
image1RW[0,0] // 100
image1RW[1,1] // 5
image1RW[0,1] // 50

var image2RW = image1RW
image2RW[0,0] // 100
image2RW[0,1] // 50
image2RW[0,1] = 150
image2RW[0,1] // 150
image1RW[0,1] // 50
image2RW[1,1] // 5
image2RW[0,0] = 200
image2RW[0,0] // 200
image1RW[0,0] // 100
image1RW[0,0] = 2
image1RW[0,0] // 2
image2RW[0,0] // 200
image1RW[0,1] = 60
image1RW[0,1] // 60
image2RW[0,1] // 150

var image3RW = image2RW
image3RW.clear(with: 255)
image3RW[0,0] // 255
image2RW[0,0] // 200
image2RW[1,1] // 5
image1RW[0,0] // 2
image1RW[0,1] // 60
image2RW[0,1] // 150
image1RW[1,1] // 5

// 3 Generic property wrapper for CopyOnWrite

private class StorageBox<StoredValue> {
    var value: StoredValue
    
    init(_ value: StoredValue) {
        self.value = value
    }
}

@propertyWrapper
    struct CopyOnWrite<T> {
        
        private var storage: StorageBox<T>
        
        init(wrappedValue: T) {
            self.storage = StorageBox(wrappedValue)
        }
        
        var wrappedValue: T {
            get {
                print("Get")
                return storage.value
            }
            set {
                if isKnownUniquelyReferenced(&storage) {
                    print("\(newValue) set by mutating boxed value")
                    storage.value = newValue
                } else {
                    print("\(newValue) set by deep copying into a new box")
                    storage = StorageBox(newValue)
                }
            }
        }
    }


struct Foo {
    @CopyOnWrite var x = 5
    
}

var f = Foo()
var g = f
print(f.x)
print(g.x)
f.x = 6
print(f.x)
print(g.x)
g.x = 10
print(f.x)
print(g.x)

// 4 Implement @ValueSemantic

protocol DeepCopyable {
    func deepCopy() -> Self
}

@propertyWrapper
    struct ValueSemantic<T:DeepCopyable> {
        private var storage: StorageBox<T>
        
        init(wrappedValue: T) {
            self.storage = StorageBox(wrappedValue)
        }
        
        var wrappedValue: T {
            mutating get {
                print("Get")
                if isKnownUniquelyReferenced(&storage) {
                    print("Getting the one instance in the uniqely held box")
                    return storage.value
                } else {
                    print("Getting after deep copying to ensure we return an isolated instance")
                    storage = StorageBox(storage.value.deepCopy())
                    return storage.value
                }
            }
            set {
                print("Set")
                if isKnownUniquelyReferenced(&storage) {
                    print("Setting by mutating boxed value")
                    storage.value = newValue
                } else {
                    print("Setting by deep copying the value into a new box")
                    storage = StorageBox(newValue)
                }
            }
        }
    }

extension NSMutableString: DeepCopyable {
    func deepCopy() -> Self {
        self.mutableCopy() as! Self
    }
}

do {
    struct Foo {
        @ValueSemantic var x = NSMutableString.init(string: "hello")
    }
    
    print("valuesemantics")
    var f = Foo()
    var g = f
    f.x = "world"
    print(f.x)
    print(g.x)
    f.x = "world"
    print(f.x)
    print(g.x)
    
    var a = Foo()
    var b = a
    print(a.x)
    print(b.x)
    a.x.append(" world")
    print(a.x)
    print(b.x)
}

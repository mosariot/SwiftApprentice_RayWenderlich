import UIKit

// Classic Approach

func greet(name: String) -> NSAttributedString {
    let attributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
    let message = NSMutableAttributedString()
    message.append(NSAttributedString(string: "Hello "))
    message.append(NSAttributedString(string: name, attributes: attributes))
    let attributes2 = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
                       NSAttributedString.Key.foregroundColor : UIColor.blue]
    message.append(NSAttributedString(string: ", Mother of Dragons", attributes: attributes2))
    return message
}
greet(name: "Daenerys")

// Result Builder Approach

typealias Text = NSMutableAttributedString

enum SpecialCharacters {
    case lineBreak
    case comma
}

@resultBuilder
enum AttributedStringBuilder {
    
    static func buildExpression(_ expression: NSAttributedString) -> NSAttributedString {
        expression
    }
    
    static func buildExpression(_ expression: SpecialCharacters) -> NSAttributedString {
        switch expression {
        case .lineBreak:
            return Text("\n")
        case .comma:
            return Text(",")
        }
    }
    
    static func buildArray(_ components: [NSAttributedString]) -> NSAttributedString {
        let attributedString = Text()
        for component in components {
            attributedString.append(component)
        }
        return attributedString
    }
    
    static func buildEither(first component: NSAttributedString) -> NSAttributedString {
        component
    }
    
    static func buildEither(second component: NSAttributedString) -> NSAttributedString {
        component
    }
    
    static func buildOptional(_ component: NSAttributedString?) -> NSAttributedString {
        component ?? NSAttributedString()
    }
    
    static func buildBlock(_ components: NSAttributedString...) -> NSAttributedString {
        let attributedString = Text()
        for component in components {
            attributedString.append(component)
        }
        return attributedString
    }
}

@AttributedStringBuilder
func greetBuider(name: String, titles: [String]) -> NSAttributedString {
    Text("Hello ")
    Text(name)
        .color(.red)
    if !titles.isEmpty {
        for title in titles {
            SpecialCharacters.comma
            SpecialCharacters.lineBreak
            Text(title)
                .font(.systemFont(ofSize: 20))
                .color(.blue)
        }
    } else {
        Text(", No title")
    }
}

let titles = ["Khaleesi", "Mhysa", "First of Her Name", "Silver Lady", "The Mother of Dragons"]

greetBuider(name: "Daenerys", titles: titles)

extension NSMutableAttributedString {
    public func color(_ color: UIColor) -> NSMutableAttributedString {
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: 0, length: self.length))
        return self
    }
    
    public func font(_ font: UIFont) -> NSMutableAttributedString {
        self.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: self.length))
        return self
    }
    
    convenience init(_ string: String) {
        self.init(string: string)
    }
}

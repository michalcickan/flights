import Foundation

protocol StringConvertible {
    var stringValue: String { get }
}

/// For structs and clasess
protocol ObjectStringConvertible: StringConvertible {
}

/// For simple objects like RawRepresentable, String, Bool etc.
protocol SimpleValueStringConvertible: StringConvertible {
}

extension ObjectStringConvertible {
    var stringValue: String {
        let mirror = Mirror(reflecting: self)
        var properties = [String]()
        mirror.children.forEach { child in
            guard var label = child.label else {
                return
            }
            label = label.replacingOccurrences(of: "_", with: "")
            if let value = child.value as? ObjectStringConvertible {
                properties.append("\(label):{\(value.stringValue)}")
            } else if let value = child.value as? SimpleValueStringConvertible {
                properties.append("\(label):\(value.stringValue)")
            } else if let value = child.value as? Array<StringConvertible> {
                properties.append("\(label):[\(value.stringValue)]")
            }
        }
        return properties.joined(separator: ",")
    }
}

fileprivate extension Array where Element == StringConvertible {
    var stringValue: String {
        map { $0.stringValue }
        .joined(separator: ",")
    }
}

extension Bool: SimpleValueStringConvertible {
    var stringValue: String { String(describing: self) }
}

extension String: SimpleValueStringConvertible {
    var stringValue: String { "\"\(self)\"" }
}

extension Int: SimpleValueStringConvertible {
    var stringValue: String { String(describing: self) }
}

extension SimpleValueStringConvertible where Self: RawRepresentable {
    var stringValue: String {
        "\(rawValue)"
    }
}

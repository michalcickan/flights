import Foundation

protocol ParametersStringConvertible {
    var stringValue: String { get }
}

extension ParametersStringConvertible {
    var stringValue: String {
        let mirror = Mirror(reflecting: self)
        var properties = [String]()
        mirror.children.forEach { child in
            guard let label = child.label else {
                return
            }
            if let value = child.value as? ParametersStringConvertible {
                properties.append("\(label):{\(value.stringValue)}")
            } else if let value = child.value as? String {
                properties.append("\(label):\"\(value)\"")
            } else if let value = child.value as? (any RawRepresentable) {
                properties.append("\(label):\(value.rawValue)")
            } else if let value = child.value as? Array<ParametersStringConvertible> {
                properties.append("\(label):[\(value.stringValue)]")
            } else if let value = child.value as? Optional<Any> {
                switch value {
                case .none:
                    return
                default:
                    properties.append("\(label):\(unwrap(child.value))")
                }
            }
        }
        return properties.joined(separator: ",")
    }
}

fileprivate extension Array where Element == ParametersStringConvertible {
    var stringValue: String {
        map { el in
            if let rawRepresentable = el as? (any RawRepresentable) {
                return "\(rawRepresentable.rawValue)"
            }
            return el.stringValue
        }
        .joined(separator: ",")
    }
}

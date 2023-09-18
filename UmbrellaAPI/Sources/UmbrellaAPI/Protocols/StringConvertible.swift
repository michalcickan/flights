import Foundation

protocol StringConvertible {
    var stringValue: String { get }
}

protocol ParametersStringConvertible {
    var stringValue: String { get }
}

extension StringConvertible where Self: Any {
    var stringValue: String {
        if let queryObject = self as? (any QueryObject) {
            return queryObject.formattedStringValue
        } else {
            let mirror = Mirror(reflecting: self)
            var properties = [String]()
            mirror.children.forEach { child in
                if let queryObject = child.value as? (any QueryObject) {
                    properties.append(queryObject.formattedStringValue)
                } else if let label = child.label, child.value as? String == "" {
                    properties.append(label)
                }
            }
            return properties.joined(separator: " ")
        }
    }
}

fileprivate extension QueryObject {
    var formattedStringValue: String {
        var properties = [name]
        if let parameters = parameters {
            properties.append("(\(parameters.stringValue))")
        }
        properties.append("{\(body.stringValue)}")
        return properties.joined(separator: " ")
    }
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

extension Array where Element == ParametersStringConvertible {
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

func unwrap<T>(_ any: T) -> Any {
    let mirror = Mirror(reflecting: any)
    guard mirror.displayStyle == .optional, let first = mirror.children.first else {
        return any
    }
    return unwrap(first.value)
}

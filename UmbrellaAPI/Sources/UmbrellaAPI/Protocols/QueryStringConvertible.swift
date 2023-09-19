import Foundation

protocol QueryStringConvertible {
    var stringValue: String { get }
}

extension QueryStringConvertible where Self: Any {
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

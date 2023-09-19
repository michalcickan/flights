import Foundation

protocol QueryObject {
    associatedtype Parameters: ParametersStringConvertible
    associatedtype Body: QueryStringConvertible
    
    var name: String { get }
    var parameters: Parameters? { get }
    var body: Body { get }
}

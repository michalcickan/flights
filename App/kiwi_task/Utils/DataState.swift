import Foundation

enum DataState<T> {
    case loading
    case ready(_ data: T)
    case error(_ error: String)
}

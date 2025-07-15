import Foundation

enum DataState<T: Hashable> {
    case loading
    case ready(_ data: T)
    case error(_ error: String)
}

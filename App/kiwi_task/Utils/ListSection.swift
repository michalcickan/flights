import Foundation

struct ListSection<T: Hashable>: Identifiable, Hashable {
    var id: Self { self }
    
    let title: String
    let items: [T]
}

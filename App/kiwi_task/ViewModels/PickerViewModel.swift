import Foundation
import Combine

final class PickerViewModel<T: Hashable>: ObservableObject, Identifiable, Equatable {
    var id: [T] { items }
    
    // not working
//    @Published var selected: T
    var items: [T]
    var selected: T
    var title: T
    let onSelected: PassthroughSubject<T, Never>
    
    init(items: [T],
         selected: T,
         title: T,
         onSelected: PassthroughSubject<T, Never>) {
        self.items = items
        self.selected = selected
        self.title = title
        self.onSelected = onSelected
    }
}

extension PickerViewModel: Hashable {
    static func == (lhs: PickerViewModel<T>, rhs: PickerViewModel<T>) -> Bool {
        lhs.items == rhs.items
    }
    
    func hash(into hasher: inout Hasher) {
        items.forEach { $0.hash(into: &hasher) }
    }
}

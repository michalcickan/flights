import Foundation
import Combine

enum SearchItem: Identifiable, Hashable {
    var id: Self { self }
    
    case searchResult(_ viewModel: TileViewModel)
    case empty(_ info: String)
}

protocol SearchPlacesInput: AnyObject {
    var searchText: String { get set }
    var confirm: PassthroughSubject<Void, Never> { get }
}

protocol  SearchPlacesOutput: ObservableObject {
    var items: [SearchItem] { get }
    var close: AnyPublisher<Void, Never> { get }
}

protocol  SearchPlacesViewModelType: ObservableObject {
    var input: SearchPlacesInput { get set }
    var output: any SearchPlacesOutput { get }
}

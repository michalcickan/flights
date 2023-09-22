import Foundation
import Combine

enum FilterListWithTagsType {
    case source, destination
}

enum FilterItem: Hashable, Equatable, Identifiable {
    var id: Self { self }
    
    case listWithTags(_ viewModel: TileViewModel, type: FilterListWithTagsType)
    case stepper(_ viewModel: StepperViewModel)
    case picker(_ viewModel: PickerViewModel<String>)
}

protocol FilterOptionsInput: AnyObject {
    var onAppear: PassthroughSubject<Void, Never> { get }
    var adults: Int { get set }
    var onDisappear: PassthroughSubject<Void, Never> { get }
}

protocol FilterOptionsOutput: ObservableObject {
    var showRoute: AnyPublisher<SceneRoute, Never> { get }
    var sections: DataState<[ListSection<FilterItem>]> { get }
    var sceneTitle: String { get }
}

protocol FilterOptionsViewModelType: ObservableObject {
    var input: FilterOptionsInput { get set }
    var output: any FilterOptionsOutput { get }
}

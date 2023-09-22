import Foundation
import CoreLocation
import Combine
import UmbrellaAPI

final class FilterOptionsViewModel: FilterOptionsOutput, FilterOptionsInput {
    typealias Done = (PersistentFilter) -> Void
    
    @Published private(set) var sections: DataState<[ListSection<FilterItem>]> = .loading
    
    // Output
    private var _showRoute = PassthroughSubject<SceneRoute, Never>()
    var showRoute: AnyPublisher<SceneRoute, Never> {
        _showRoute.eraseToAnyPublisher()
    }
    var sceneTitle: String { "Filter setup" }
    
    // Input
    let onAppear = PassthroughSubject<Void, Never>()
    var onDisappear = PassthroughSubject<Void, Never>()
    @Published var adults: Int = 1
    
    // Rest
    private var locationManager: LocationManager?
    private var cancellables: Set<AnyCancellable> = []
    @Published private var selectedQuality = ""
    
    @Published private var filter = PersistentFilter()
    private var cabinType =  PassthroughSubject<String, Never>()
    private var sortBy = PassthroughSubject<String, Never>()
    
    private let service: FilterOptionsServiceType
    private let persistentStorage: PersistenStorage
    
    init(service: FilterOptionsServiceType,
         persistenStorage: PersistenStorage,
         done: @escaping Done) {
        self.service = service
        self.persistentStorage = persistenStorage
        onAppear
            .flatMap { [unowned self] _ -> Future<PersistentFilter, Never> in
                guard let filter = persistenStorage.filter else {
                    return self.getDefaultFilter(
                        service: service,
                        persistentStorage: persistenStorage
                    )
                }
                return Future.init {
                    $0(.success(filter))
                }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.filter, on: self)
            .store(in: &cancellables)
        
        $filter
            .drop(untilOutputFrom: onAppear)
            .receive(on: RunLoop.main)
            .map { [unowned self] filter in
                persistenStorage.filter = filter
                return .ready([
                    self.makeSection(
                        with: filter,
                        and: persistenStorage.places ?? []
                    )
                ])
            }
            .assign(to: \.sections, on: self)
            .store(in: &cancellables)
        
        
        Publishers.Merge(
            sortBy.map { [unowned self] sort in
                self.filter.copyWith(sortBy: .init(rawValue: sort))
            },
            cabinType.map { [unowned self] cabin in
                self.filter.copyWith(cabinClassType: .init(rawValue: cabin))
            }
        )
        .assign(to: \.filter, on: self)
        .store(in: &cancellables)
        
        $adults
            .dropFirst()
            .map {
                self.filter.copyWith(numberOfAdults: $0)
            }
            .assign(to: \.filter, on: self)
            .store(in: &cancellables)
        onDisappear
            .map { [unowned self] in self.filter}
            .sink(receiveValue: done)
            .store(in: &cancellables)
    }
}

private extension FilterOptionsViewModel {
    func getDefaultFilter(service: FilterOptionsServiceType,
                          persistentStorage: PersistenStorage) -> Future<PersistentFilter, Never> {
        let locationManager = LocationManager()
        self.locationManager = locationManager
        return Future { promise in
            Task {
                let sourceLocations: [String]
                var fetchedPlaces = [PersistentPlace]()
                defer {
                    persistentStorage.places = fetchedPlaces
                    promise(
                        .success(
                            PersistentFilter(
                                sources: sourceLocations,
                                destinations: Config.defaultDestinationIds,
                                cabinClassType: .economy,
                                sortBy: .quality,
                                numberOfAdults: 1,
                                adultsHoldBags: nil
                            )
                        )
                    )
                }
                let destinationPlaces = try? await service.fetchLocations(parameters: PlacesQueryParameters(
                    search: PlacesQueryParameters.Search(ids: Config.defaultDestinationIds))
                )
                fetchedPlaces.append(
                    contentsOf: destinationPlaces?.edges?.persistentPlaces ?? []
                )
                guard let location = try? await locationManager.requestLocation(),
                      let placesBasedOnLocation = await location.fetchLocations(service: service) else {
                    let defaultSourcePlaces = try? await service.fetchLocations(
                        parameters: PlacesQueryParameters(
                            search: PlacesQueryParameters.Search(ids: Config.defaultSourceIds)
                        )
                    )
                    fetchedPlaces.append(contentsOf: defaultSourcePlaces?.edges?.persistentPlaces ?? [])
                    sourceLocations = Config.defaultSourceIds
                    return
                }
                fetchedPlaces.append(contentsOf: placesBasedOnLocation.edges?.persistentPlaces ?? [])
                sourceLocations = placesBasedOnLocation.edges?.compactMap { $0.node?.id } ?? Config.defaultSourceIds
            }
        }
    }
    
    func makeSection(with filter: PersistentFilter,
                     and places: [PersistentPlace]) -> ListSection<FilterItem> {
        ListSection<FilterItem>(
            title: "",
            items: [
                .listWithTags(
                    TileViewModel(
                        title: "Source",
                        tags: filter.sources?.locationNames(with: places) ?? []
                    ) { [weak self] in
                        guard let self else { return }
                        self._showRoute.send(.searchPlaces { [weak self] places in
                            self?.persistentStorage.places = places.persistentPlaces
                            guard let self = self else { return }
                            self.filter = self.filter.copyWith(
                                sources: places.compactMap { $0.node?.id }
                            )
                        })
                    },
                    type: .source
                ),
                .listWithTags(
                    TileViewModel(
                        title: "Destination",
                        tags: filter.destinations?.locationNames(with: places) ?? []
                    ) { [weak self] in
                        guard let self else { return }
                        self._showRoute.send(.searchPlaces { [weak self] places in
                            self?.persistentStorage.places = places.persistentPlaces
                            guard let self = self else { return }
                            self.filter = self.filter.copyWith(
                                destinations: places.compactMap { $0.node?.id }
                            )
                        })
                        
                    },
                    type: .destination
                ),
                .stepper(
                    StepperViewModel(
                        title: "Adults",
                        minValue: 0,
                        maxValue: 10
                    )
                ),
                .picker(PickerViewModel<String>(
                    items:
                        CabinClassType.allCases.map {
                            $0.rawValue
                        },
                    selected: filter.cabinClassType?.rawValue ?? "",
                    title: "Cabin class",
                    onSelected: self.cabinType
                )),
                .picker(
                    PickerViewModel<String>(
                        items:
                            ItinerariesOptionsInput.SortBy.allCases.map {
                                $0.rawValue
                            },
                        selected: filter.sortBy?.rawValue ?? "",
                        title: "Sort by",
                        onSelected: self.sortBy
                    )
                )
            ]
        )
    }
}

extension FilterOptionsViewModel: FilterOptionsViewModelType {
    var output: any FilterOptionsOutput { self }
    var input: FilterOptionsInput { get { self } set { } }
}

fileprivate extension CLLocationCoordinate2D {
    func fetchLocations(service: FilterOptionsServiceType) async -> PlaceConnection? {
        try? await service
            .fetchLocations(
                parameters: PlacesQueryParameters(
                    search: nil,
                    filter: PlacesQueryParameters.Filter(
                        onlyTypes: [.airport, .city]
                    ),
                    options: PlacesQueryParameters.Options(
                        gps: GPS(
                            lat: latitude,
                            lng: longitude
                        )
                    ),
                    first: 10
                )
            )
    }
}

fileprivate extension Array where Element == String {
    func locationNames(with places: [PersistentPlace]) -> [String] {
        compactMap { sourceId in
            places.first(where: { $0.id == sourceId })?.name
        }
    }
}

import Foundation
import Combine
import UmbrellaAPI

final class FlightListViewModel: ObservableObject, FlightListOutput, FlightListInput {
    static var numberOfDays: Int = 5
    static var limit: Int = 5
    // MARK: - Output
    @Published var flights: [CardViewModel] = []
    let _showRoute = PassthroughSubject<SceneRoute, Never>()
    var showRoute: AnyPublisher<SceneRoute, Never> {
        _showRoute.eraseToAnyPublisher()
    }
    
    var _showError = PassthroughSubject<String, Never>()
    var showError: AnyPublisher<String, Never> {
        _showError.eraseToAnyPublisher()
    }
    @Published private var days: [Int: [Itinerary]] = [:]
    @Published var day: Day = .loading
    var segmentTitles: [String] {
        (0..<FlightListViewModel.numberOfDays).map {
            Date().addDays($0).dayName
        }
    }
    
    // MARK: - Input
    var onFiltersTap = PassthroughSubject<Void, Never>()
    let onAppear = PassthroughSubject<Void, Never>()
    @Published var currentSegmentIndex: Int = 0
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(service: FlightListServiceType, persistStore: PersistenStorage) {
        onAppear
            .sink(receiveValue: { [unowned self] filter in
                guard persistStore.filter != nil else {
                    self._showRoute.send(
                        .filter(done: self.handleFilterEnding)
                    )
                    return
                }
            })
            .store(in: &cancellables)
        
        let newResults = $currentSegmentIndex
            .filter { [weak self] currentIndex in
                self?.days[currentIndex] == nil
            }
            .flatMap { [weak self] (currentIndex)  in
                service.fetchOnewayItineraries(
                    filter: persistStore.filter ?? PersistentFilter(),
                    addDays: currentIndex,
                    totalItinerariesCount: self?.allItineraryIds.count ?? 0
                )
                .makeOptionableIfError(self?._showError)
            }
            .compactMap { $0 }
            .map { [weak self] newData in
                guard let self else { return newData }
                let allItineraryIds = self.allItineraryIds
                return Array(
                    newData.filter {
                        !allItineraryIds.contains($0.id ?? "")
                    }
                        .prefix(FlightListViewModel.limit)
                )
            }
            .filter { $0.isEmpty }
            .receive(on: RunLoop.main)
            .map { [weak self] newData in
                guard let self else { return newData }
                self.days[self.currentSegmentIndex] = newData
                return newData
            }
            .receive(on: DispatchQueue.global())
            .map(parseItineraries)
            .receive(on: RunLoop.main)
        Publishers.Merge(
            newResults,
            $currentSegmentIndex
                .map { [unowned self] index in
                    guard let itineraries = self.days[index] else {
                        return .loading
                    }
                    return self.parseItineraries(itineraries)
                }
        )
        .receive(on: RunLoop.main)
        .assign(to: \.day, on: self)
        .store(in: &cancellables)
        onFiltersTap
            .sink { [unowned self] in
                self._showRoute.send(
                    .filter(done: self.handleFilterEnding)
                )
            }
            .store(in: &cancellables)
    }
}

private extension FlightListViewModel {
    var handleFilterEnding: (PersistentFilter) -> Void {
        { [unowned self] filter in
            self.clearCache()
            self.currentSegmentIndex = 0
        }
    }
    func clearCache() {
        self.days = [:]
        self.day = .loading
    }
    var parseItineraries:  ([Itinerary]) -> Day {
        { itineraries in
            itineraries.isEmpty ? .error("Something went wrong") :
                .ready(
                    itineraries.map { itinerary in
                        return FlightCardViewModel(
                            id: itinerary.id ?? "",
                            legacyId: itinerary.sector?.sectorSegments?.last?.segment?.destination?.station?.city?.legacyId,
                            formattedPrice: itinerary.price?.formattedValue ?? "-",
                            direction: itinerary.sector?.direction ?? "-",
                            numberOfStopOvers: (itinerary.sector?.sectorSegments?.count ?? 0) % 2,
                            duration: itinerary.duration ?? 0
                        ) { [unowned self] in
                            self._showRoute.send(.flightDetail(itinerary))
                            
                        }
                    }
                )
        }
    }
    
    var allItineraryIds: [String] {
        days.flatMap { day in day.value.compactMap { $0.id } }
    }
}

extension FlightListViewModel: FlightListViewModelType {
    var output: any FlightListOutput { self }
    var input: FlightListInput { get { self } set { } }
}

fileprivate extension FlightListServiceType {
    func fetchOnewayItineraries(filter: PersistentFilter, addDays: Int, totalItinerariesCount: Int) -> Future<[Itinerary], Error> {
        Future { promise in
            Task {
                do {
                    let date = Date().addDays(addDays)
                    let parameters = OnewayFlightSearchParameters(
                        filter: .init(
                            allowChangeInboundSource: false,
                            allowChangeInboundDestination: false,
                            allowDifferentStationConnection: true,
                            allowOvernightStopover: true,
                            contentProviders: [.kiwi],
                            // ensure, that always be at least 5
                            limit: FlightListViewModel.limit + totalItinerariesCount,
                            showNoCheckedBags: true,
                            transportTypes: [.flight]
                        ),
                        options: .init(
                            currency: "EUR",
                            partner: "skypicker",
                            sortBy: filter.sortBy ?? .quality,
                            sortOrder: .asc,
                            sortVersion: 4,
                            storeSearch: true
                        ),
                        search: .init(
                            cabinClass: .init(
                                applyMixedClasses: true,
                                cabinClass: filter.cabinClassType ?? .economy
                            ),
                            itinerary: .init(
                                source: .init(ids: filter.sources ?? Config.defaultSourceIds),
                                destination: .init(ids: filter.destinations ?? Config.defaultDestinationIds),
                                outboundDepartureDate: .init(
                                    start: date.startOfDay,
                                    end: date.endOfDay
                                )
                            ),
                            passengers: .init(
                                adults: filter.numberOfAdults
                            )
                        )
                    )
                    let result = try await fetchOnewayFlights(parameters: parameters)
                    promise(.success(result.itineraries ?? []))
                } catch  {
                    promise(.failure(error))
                }
            }
        }
    }
}

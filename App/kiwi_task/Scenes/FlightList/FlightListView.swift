import Foundation
import SwiftUI
import Orbit

struct FlightListView<VM: FlightListViewModelType>: View {
    @StateObject private var viewModel: VM
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var persistenStore: PersistenStorage
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        RoutingView(router: router) {
            VStack {
                SegmentedSwitch(selection: $viewModel.input.currentSegmentIndex) {
                    ForEach(0..<viewModel.output.segmentTitles.count, id: \.self) {
                        Text(viewModel.output.segmentTitles[$0])
                            .identifier($0)
                    }
                }
                .padding()
                Spacer()
                daySegment(day: viewModel.output.day)
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Flights")
            .toolbar {
                Orbit.Button(icon: .filters, type: .secondary) {
                    viewModel.input.onFiltersTap.send()
                }
                .padding()
            }
            .onAppear {
                viewModel.input.onAppear.send()
            }
            .onReceive(viewModel.output.showRoute) { route in
                router.show(route, as: route.routeType)
            }
        }
    }
}

private extension FlightListView {
    @ViewBuilder func daySegment(day: FlightListOutput.Day) -> some View {
        switch day {
        case .loading:
            VStack {
                ProgressView()
            }
        case let .ready(data):
            HorizontalScroll(spacing: 20, itemWidth: .fixed(200)) {
                ForEach(data, id: \.self) { flight in
                    // Card(action: .buttonLink("", action: flight.onTap)) {
                    Card(action: .buttonLink("", action: flight.onTap)) {
                        if flight.imageUrl != nil {
                            AsyncImage(url: flight.imageUrl!, scale: 3)
                        }
                        HStack {
                            Heading(flight.direction, style: .title5)
                            Spacer()
                            Heading(flight.formattedPrice, style: .title5)
                        }
                        Text(flight.numberOfStopOvers)
                        Text(flight.duration)
                    }
                    .onTapGesture { flight.onTap() }
                }
            }
        case let .error(error):
            Alert("Oops", description: error)
        }
    }
}

struct FlightListView_Previews: PreviewProvider {
    static var previews: some View {
        FlightListView(
            viewModel: FlightListViewModel(
                service: FlightListService(
                    client: PreviewAPIClient()
                ),
                persistStore: PersistenStorage()
            )
        )
        .environmentObject(Router(isPresented: .constant(.flightList)))
    }
}

fileprivate extension SceneRoute {
    var routeType: Router.RouteType {
        switch self {
        case .filter, .flightDetail:
            return .sheet
        default:
            return .navigation
        }
    }
}

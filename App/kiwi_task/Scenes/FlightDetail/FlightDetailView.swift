import Foundation
import SwiftUI
import Orbit

struct FlightDetailView<VM: FlightDetailViewModelType>: View {
    @StateObject private var viewModel: VM
    @EnvironmentObject private var router: Router
    
    @State var summaryExpanded = false
    @State var linksExpanded = false
    @State var stopExpanded = false
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        RoutingView(router: router) {
            ScrollView {
                VStack(spacing: 5) {
                    Collapse("Summary info") {
                        HStack {
                            Heading("Price", style: .title4)
                            if viewModel.output.highlightTag == .cheapest {
                                Tag("The cheapest", isSelected: .constant(true))
                            }
                            Spacer()
                            Text(viewModel.output.price)
                        }.padding(.bottom, 10)
                        HStack {
                            Heading("Duration", style: .title4)
                            if viewModel.output.highlightTag == .fastest {
                                Tag("The fastest", isSelected: .constant(true))
                            }
                            Spacer()
                            Text(viewModel.output.totalDuration)
                        }
                        
                    }
                    Collapse(
                        "Booking links",
                    ) {
                        ForEach(viewModel.output.bookingLinks, id: \.self) {
                                Link($0.title, destination: $0.destinationUrl)
                        }
                    }
                    Collapse("Stops") {
                        ForEach(viewModel.output.stops.items, id: \.self) { item in
                            Card(item.title, description: item.description) {
                                if item.imageUrl != nil {
                                    AsyncImage(url: item.imageUrl!, scale: 2)
                                        .aspectRatio(contentMode: .fit)
                                }
                            }
                        }
                    }
                    
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.output.title)
        }
    }
}

struct FlightDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FlightDetailView(
            viewModel: FlightDetailViewModel(itinerary: .init())
        )
        .environmentObject(Router(isPresented: .constant(.flightList)))
    }
}

import Foundation
import SwiftUI
import Orbit

struct FilterOptionsView<VM: FilterOptionsViewModelType>: View {
    @StateObject private var viewModel: VM
    @EnvironmentObject private var router: Router
    @State private var picker: PickerViewModel<String>?
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        RoutingView(router: router) {
            switch viewModel.output.sections {
            case .loading:
                VStack {
                    ProgressView()
                }
                .navigationTitle(viewModel.output.sceneTitle)
            case let .ready(sections):
                List(sections) { section in
                    Section(section.title) {
                        ForEach(section.items) { item in
                            switch item {
                            case let .picker(selectionViewModel):
                                Tile(
                                    selectionViewModel.title,
                                    description: selectionViewModel.selected,
                                    disclosure: .icon(.chevronUp),
                                    action: {
                                        picker = selectionViewModel
                                    }
                                )
                            case let .listWithTags(viewModel, type):
                                // This is weird. It sometimes catch tap gesture and always only when tap on the top right. Seems to me like a bug of Tile with custom content
                                Tile(
                                    viewModel.title,
                                    icon: type == .destination ? .airplaneLanding : .airplaneUp,
                                    action: viewModel.onTap,
                                    content: {
                                        if viewModel.tags == nil {
                                            EmptyView()
                                        } else if viewModel.tags!.isEmpty {
                                            EmptyState(illustration: .placeholderAirport)
                                        }  else {
                                            buildTags(tags: viewModel.tags!)
                                        }
                                    }
                                )
                            case let .stepper(stepper):
                                HStack {
                                    Orbit.Heading(stepper.title, style: .title4)
                                    Spacer()
                                    Stepper(
                                        value: $viewModel.input.adults,
                                        minValue: stepper.minValue,
                                        maxValue: stepper.maxValue,
                                        style: .secondary
                                    )
                                }
                                .padding()
                            }
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle(viewModel.output.sceneTitle)
                    .listRowInsets(EdgeInsets())
                }
            case let .error(error):
                VStack {
                    Orbit.Alert(
                        "Oops",
                        description: error.description,
                        icon: .alertCircle
                    )
                }
                .padding(.horizontal)
            }
        }
        .sheet(item: $picker) { picker in
            List {
                ForEach(picker.items, id: \.self) { item in
                    ChoiceTile(item, isSelected: item == picker.selected) { [unowned picker] in
                        picker.onSelected.send(item)
                        self.picker = nil
                    }
                }
            }
        }
        .onAppear {
            viewModel.input.onAppear.send()
        }
        .onReceive(viewModel.output.showRoute) {
            router.show($0, as: .sheet)
        }
        .onDisappear {
            viewModel.input.onDisappear.send()
        }
    }
}

private extension FilterOptionsView {
    @ViewBuilder func buildTags(tags: [String]) -> some View {
        HorizontalScroll(
            isSnapping: true,
            spacing: .xxxSmall,
            itemWidth: .ratio(
                2,
                maxWidth: .infinity
            )
        ) {
            
            HStack {
                ForEach(tags, id: \.self) {
                    Badge($0)
                        .lineLimit(1)
                }
            }
            
        }
        .padding(
            EdgeInsets.init(
                top: 0,
                leading: 10,
                bottom: 10,
                trailing: 0
            )
        )
    }
    
    @ViewBuilder func buildPicker(models: [String]) -> some View {
        ForEach(models, id: \.self) {
            Text($0)
        }
    }
}

struct FilterOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        FilterOptionsView(
            viewModel: FilterOptionsViewModel(
                service: FilterOptionsService(client: PreviewAPIClient()),
                persistenStorage: PersistenStorage()
            ) { _ in
                
            }
        )
        .environmentObject(
            Router(
                isPresented: .constant(
                    .filter { _ in }
                )
            )
        )
    }
}

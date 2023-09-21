import Foundation
import SwiftUI

struct StepperViewModel: Hashable, Identifiable {
    var id: Self { self }
    
    static func == (lhs: StepperViewModel, rhs: StepperViewModel) -> Bool {
        lhs.minValue == rhs.minValue && lhs.maxValue == rhs.maxValue
    }
    
    func hash(into hasher: inout Hasher) {
        minValue.hash(into: &hasher)
        maxValue.hash(into: &hasher)
    }
    
    let title: String
    let minValue: Int
    let maxValue: Int
//    @Published var selected: String = ""
    
}


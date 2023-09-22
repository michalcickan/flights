import Foundation

struct LinkViewModel: Identifiable, Hashable {
    var id: Self { self }
    
    let title: String
    let destinationUrl: URL
}

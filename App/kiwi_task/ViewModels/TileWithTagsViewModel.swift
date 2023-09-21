import Foundation

struct TileWithTagsViewModel: Identifiable, Hashable {
    static func == (lhs: TileWithTagsViewModel, rhs: TileWithTagsViewModel) -> Bool {
        rhs.title == lhs.title && rhs.tags == lhs.tags
    }
    
    func hash(into hasher: inout Hasher) {
        title.hash(into: &hasher)
        tags.hash(into: &hasher)
    }
    
    var id: Self { self }
    
    let title: String
    let tags: [String]
    let onTap: () -> Void
}

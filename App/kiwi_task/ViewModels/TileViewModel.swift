import Foundation

struct TileViewModel: Identifiable, Hashable {
    static func == (lhs: TileViewModel, rhs: TileViewModel) -> Bool {
        rhs.title == lhs.title && rhs.tags == lhs.tags
    }
    
    func hash(into hasher: inout Hasher) {
        title.hash(into: &hasher)
        tags.hash(into: &hasher)
    }
    
    var id: Self { self }
    
    let title: String
    let description: String?
    let tags: [String]?
    let onTap: () -> Void
    let isSelected: Bool
    
    init(title: String,
         tags: [String]? = nil,
         isSelected: Bool = false,
         description: String? = nil,
         onTap: @escaping () -> Void) {
        self.title = title
        self.tags = tags
        self.onTap = onTap
        self.isSelected = isSelected
        self.description = description
    }
}

import Foundation

enum HeaderField {
    case accept(content: ContentType)
    case contentType(content: ContentType)
}

enum ContentType: String {
    case json = "application/json"
}

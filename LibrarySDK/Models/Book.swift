import Foundation

public struct Book: Codable, Hashable {
    public let isbn: String
    public let author: String
    public let title: String

    public init(isbn: String, author: String, title: String) {
        self.isbn = isbn
        self.author = author
        self.title = title
    }
}

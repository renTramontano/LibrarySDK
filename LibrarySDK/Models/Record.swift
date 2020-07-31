import Foundation

public struct Books: Codable, Hashable {
    public let books: [Book]

    public init(books: [Book]) {
        self.books = books
    }
}

import LibrarySDK

extension Book {
    static var mock: Book {
        Book(isbn: "isbn",
             author: "author",
             title: "title")
    }
}

import Foundation
import Combine

public class BookAPI {
    private var apiManger = APIManager()
    private var cancellable: AnyCancellable?

    public init() {}

    public func getBooks() -> AnyPublisher<LibrarySDK.Record, Error> {
        apiManger.makeRequest(to: APIManager.readBooksURL, withHttpMethod: .get)
            .map { $0.data }
            .decode(type: LibrarySDK.Record.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    public func setBook(isbn: String, author: String, title: String) {
        let httpBodyParameters = ["isbn": isbn, "author": author, "title": title]
        cancellable = apiManger.makeRequest(to: APIManager.createBookURL, httpBody: httpBodyParameters, withHttpMethod: .post)
            .sink(receiveCompletion: { print($0) },
                  receiveValue: { print($0) })
    }
}

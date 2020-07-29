import Foundation
import Combine

public class BooksApi {
    private var apiManger = APIManager()
    private var cancellable: AnyCancellable?

    public init() {}

    public func getNewBooks() -> AnyPublisher<LibrarySDK.Record, Error> {
        apiManger.makeRequest(to: APIManager.readURL, withHttpMethod: .get)
            .map { $0.data }
            .decode(type: LibrarySDK.Record.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    public func setBooks(isbn: String, autore: String, titolo: String) {
        let httpBodyParameters = ["ISBN": isbn, "autore": autore, "titolo": titolo]
        cancellable = apiManger.makeRequest(to: APIManager.readURL, httpBody: httpBodyParameters, withHttpMethod: .post)
            .sink(receiveCompletion: { print($0) },
                  receiveValue: { print($0) })
    }
}

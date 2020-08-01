import Foundation
import Combine

public class BookAPI {
    private var apiManger = APIManager()
    private var cancellable: AnyCancellable?

    public func getAllBooks() -> AnyPublisher<LibrarySDK.Books, Error> {
        apiManger.makeRequest(to: APIManager.readBooksURL, withHttpMethod: .get)
            .map { $0.data }
            .decode(type: LibrarySDK.Books.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    public func createNewBook(isbn: String, author: String, title: String) {
        let httpBodyParameters = ["isbn": isbn, "author": author, "title": title]
        cancellable = apiManger.makeRequest(to: APIManager.createBookURL, httpBody: httpBodyParameters, withHttpMethod: .post)
            .sink(receiveCompletion: { print($0) },
                  receiveValue: { print($0) })
    }

    public func removeBook(isbn: String) {
        let httpBodyParameters = ["isbn": isbn]
        cancellable = apiManger.makeRequest(to: APIManager.deleteBookURL, httpBody: httpBodyParameters, withHttpMethod: .post)
            .sink(receiveCompletion: { print($0) },
                  receiveValue: { print($0) })
    }

    public func modifyBook(isbn: String, author: String, title: String) {
        let httpBodyParameters = ["isbn": isbn, "author": author, "title": title]
        cancellable = apiManger.makeRequest(to: APIManager.updateBookURL, httpBody: httpBodyParameters, withHttpMethod: .post)
            .sink(receiveCompletion: { print($0) },
                  receiveValue: { print($0) })
    }
}

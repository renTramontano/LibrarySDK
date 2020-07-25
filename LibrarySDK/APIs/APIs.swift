import UIKit
import Combine

class APIManager {
    static let baseURL = "http://kingborn187.altervista.org/BibliotecaREST/libro"
    static let readURL = URL(string: baseURL + "/read.php")!
    static let createURL = URL(string: baseURL + "/create.php")!
}

public class BooksApi {
    public var cancellable: AnyCancellable?

    public init() {}

    public func getNewBooks() -> AnyPublisher<LibrarySDK.Record, Error> {
        URLSession.shared.dataTaskPublisher(for: APIManager.readURL)
            .map { $0.data }
            .decode(type: LibrarySDK.Record.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    public func setBooks(isbn: String, autore: String, titolo: String) {
        let book = Libri(ISBN: isbn, autore: autore, titolo: titolo)
        var urlReqest = URLRequest(url: APIManager.createURL)
        urlReqest.httpMethod = "POST"
        do {
            urlReqest.httpBody = try JSONEncoder().encode(book)
        } catch {}
        urlReqest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        cancellable = URLSession.shared.dataTaskPublisher(for: urlReqest)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                    case .failure(let error): print(error)
                    case .finished: print("GET - DONE")
                }
            }, receiveValue: { response in
                print(response)
            })
    }
}


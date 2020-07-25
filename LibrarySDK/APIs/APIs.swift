import UIKit

class APIManager {
    static let baseURL = "http://kingborn187.altervista.org/BibliotecaREST/libro/read.php"
    static let baseURL2 = "http://kingborn187.altervista.org/BibliotecaREST/libro/create.php"
}

public class BooksApi {
    public func getBooks() -> Record? {
        let url = APIManager.baseURL
        var record: Record?
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                record = try decoder.decode(Record.self, from: data)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
        return record
    }

    public func setBooks(isbn: String, autore: String, titolo: String) {
        let book = Libri(ISBN: isbn, autore: autore, titolo: titolo)

        do {
            let jsonData = try JSONEncoder().encode(book)
            var request = URLRequest(url: URL(string: APIManager.baseURL2)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
                guard let data = data else { return }
                print(String(data: data, encoding: .utf8)!)
            }

            task.resume()
        } catch {}
    }
}


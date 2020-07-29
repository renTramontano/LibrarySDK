import Combine

class APIManager {
    static let baseURL = "http://kingborn187.altervista.org/BibliotecaREST/libro"
    static let readURL = URL(string: baseURL + "/read.php")!
    static let createURL = URL(string: baseURL + "/create.php")!

    func makeRequest(to url: URL, httpBody parameters: [String: String] = [:], withHttpMethod httpMethod: HttpMethod) -> URLSession.DataTaskPublisher {
        let urlRequest = prepareRequest(with: url, parameters: parameters, httpMethod: httpMethod)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
    }

    private func prepareRequest(with url: URL, parameters: [String: String], httpMethod: HttpMethod) -> URLRequest {
        var urlReqest = URLRequest(url: url)
        urlReqest.httpMethod = httpMethod.rawValue
        urlReqest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlReqest.httpBody = getHttpBody(with: parameters)
        return urlReqest
    }

    private func getHttpBody(with parameters: [String: String]) -> Data? {
        guard !parameters.isEmpty else { return nil }
        return try? JSONSerialization.data(withJSONObject: parameters, options: [.prettyPrinted, .sortedKeys])
    }
}

extension APIManager {
    public enum HttpMethod: String {
        case get
        case post
        case put
        case patch
        case delete
    }
}

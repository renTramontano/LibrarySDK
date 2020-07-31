import XCTest
import LibrarySDK
import OHHTTPStubs

class BooksApiTests: XCTestCase {
    func testReadBooks() {
        stub(condition: isHost("www.kingborn187.altervista.org")) { request in
            XCTAssertEqual(request.httpMethod, APIManager.HttpMethod.get.rawValue)
            XCTAssertNil(request.httpBody)
            do {
                return HTTPStubsResponse(data: try JSONEncoder().encode(Book.mock),
                                         statusCode: 200,
                                         headers: ["Content-Type": "application/json"])
            } catch {
                XCTFail("\(error)")
                return HTTPStubsResponse(error: error)
            }
        }
    }
}

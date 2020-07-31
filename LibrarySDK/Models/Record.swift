import Foundation

public struct Record: Codable, Hashable {
    public let records: [Book]

    public init(records: [Book]) {
        self.records = records
    }
}

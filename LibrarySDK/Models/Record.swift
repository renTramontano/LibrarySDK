import Foundation

public struct Record: Codable, Hashable {
    public let records: [Libri]

    public init(records: [Libri]) {
        self.records = records
    }
}

import Foundation

public struct Libri: Codable, Hashable {
    public let ISBN: String
    public let autore: String
    public let titolo: String

    public init(ISBN: String, autore: String, titolo: String) {
        self.ISBN = ISBN
        self.autore = autore
        self.titolo = titolo
    }
}

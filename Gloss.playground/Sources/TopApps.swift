import Foundation

public struct TopApps: Decodable {

    // 1
    public let feed: Feed?

    // 2
    public init?(json: JSON) {
        feed = "feed" <~~ json
    }
    
}
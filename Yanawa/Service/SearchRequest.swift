
import Foundation

struct SearchRequest: APIRequestType {
    typealias Response = SearchRepositoryResponse

    var path: String { return "/search/repositories" }
    var queryItems: [URLQueryItem]? {
        return [
            .init(name: "q", value: query),
            .init(name: "order", value: "desc")
        ]
    }

    private let query: String

    init(query: String) {
        self.query = query
    }
}

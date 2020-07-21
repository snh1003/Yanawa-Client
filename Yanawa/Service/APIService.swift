
import Foundation
import Combine

protocol APIRequestType {
    associatedtype Response: Decodable

    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

protocol APIServiceType {
    func request<Request>(with request: Request) -> AnyPublisher<Request.Response, APIError> where Request: APIRequestType
}

final class APIService: APIServiceType {

    private let baseURLString: String
    init(baseURLString: String = "https://api.github.com") {
        self.baseURLString = baseURLString
    }

   func request<Request>(with request: Request) -> AnyPublisher<Request.Response, APIError> where Request: APIRequestType {

    guard let pathURL = URL(string: request.path, relativeTo: URL(string: baseURLString)) else {
        return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
    }

    var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
    urlComponents.queryItems = request.queryItems
    var request = URLRequest(url: urlComponents.url!)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let decorder = JSONDecoder()
    decorder.keyDecodingStrategy = .convertFromSnakeCase
    return URLSession.shared.dataTaskPublisher(for: request)
        .map { data, urlResponse in data }
        .mapError { _ in APIError.responseError }
        .decode(type: Request.Response.self, decoder: decorder)
        .mapError(APIError.parseError)
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}



import Foundation

enum APIError: Error {
    case invalidURL
    case responseError
    case parseError(Error)
}

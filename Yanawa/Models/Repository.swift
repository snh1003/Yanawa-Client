
import Foundation

struct Repository: Decodable, Hashable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let stargazersCount: Int = 0
    let language: String?
    let htmlUrl: String
    let owner: Owner
}

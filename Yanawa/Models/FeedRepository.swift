

import Foundation

struct FeedRepository: Decodable, Hashable, Identifiable {
    let id: Int
    let title: String
    let text: String
    let time: String
    let location: String
    let peaple: Int
    let date: String
}

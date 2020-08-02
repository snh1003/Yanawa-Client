

import Foundation
import Combine


final class FeedViewModel: ObservableObject {
    
    // MARK: - Outputs
    @Published var title = ""
    @Published var location = ""
    @Published var text = ""
    @Published var date = ""
    @Published var peaple = 0
    @Published var time = ""
    
    init(apiService: APIServiceType) {
        self.apiService = apiService
    }
    // MARK: - Private
    private let apiService: APIServiceType
    private let responseSubject = PassthroughSubject<FeedResponse, Never>()
    private let errorSubject = PassthroughSubject<APIError, Never>()
    private var cancellables: [AnyCancellable] = []
    
    /*
     api bind 처리
     */
}


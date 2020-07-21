
import Foundation
import Combine
import UIKit

final class HomeViewModel: ObservableObject {

    // MARK: - Inputs
    enum Inputs {
        case submit(text: String)
        case tapCardView(urlString: String)
    }

    // MARK: - Outputs
    @Published private(set) var cardViewInputs: [CardView.Input] = []
    @Published var inputText: String = ""
    @Published var isError = false
    @Published var isLoading = false
    @Published var isSheet = false
    @Published var repositoryUrl: String = ""

    init(apiService: APIServiceType) {
        self.apiService = apiService
        bind()
    }

    func apply(inputs: Inputs) {
        switch inputs {
            case .submit(let inputText):
                textSubject.send(inputText)
            case .tapCardView(let urlString):
                repositoryUrl = urlString
                isSheet = true
        }
    }

    // MARK: - Private
    private let apiService: APIServiceType
    private let textSubject = PassthroughSubject<String, Never>()
    private let responseSubject = PassthroughSubject<SearchRepositoryResponse, Never>()
    private let errorSubject = PassthroughSubject<APIError, Never>()
    private var cancellables: [AnyCancellable] = []

    private func bind() {
        let responseSubscriber = textSubject
            .flatMap { [apiService] (query) in
                apiService.request(with: SearchRequest(query: query))
                    .catch { [weak self] error -> Empty<SearchRepositoryResponse, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                    }
            }
            .map{ $0.items }
            .sink(receiveValue: { [weak self] (repositories) in
                guard let self = self else { return }
                self.cardViewInputs = self.convertInput(repositories: repositories)
                self.inputText = ""
                self.isLoading = false
            })

        let loadingSubscriber = textSubject
            .map { _ in true }
            .assign(to: \.isLoading, on: self)

        let errorSubscriber = errorSubject
            .sink(receiveValue: { [weak self] (error) in
                guard let self = self else { return }
                self.isError = true
                self.isLoading = false
            })

        cancellables += [
            responseSubscriber,
            loadingSubscriber,
            errorSubscriber
        ]
    }

    private func convertInput(repositories: [Repository]) -> [CardView.Input] {
        return repositories.compactMap { (data) -> CardView.Input? in
            do {
                guard let avaUrl = URL(string: data.owner.avatarUrl) else {
                    return nil
                }
                let imgData = try Data(contentsOf: avaUrl)
                guard let image = UIImage(data: imgData) else { return nil }
                return CardView.Input(iconImage: image,
                                      title: data.name,
                                      language: data.language,
                                      star: data.stargazersCount,
                                      description: data.description,
                                      url: data.htmlUrl)

            } catch {
                return nil
            }
        }
    }
}

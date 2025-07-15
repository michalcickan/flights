import Foundation
import Combine

extension Future {
    func makeOptionableIfError(_ errorPublisher: PassthroughSubject<String, Never>?) -> AnyPublisher<Output?, Never> {
        self
            .map { $0 as Output? }
            .catch { error -> Just<Output?> in
                errorPublisher?.send(error.localizedDescription)
                return Just(nil)
            }
            .eraseToAnyPublisher()
    }
}

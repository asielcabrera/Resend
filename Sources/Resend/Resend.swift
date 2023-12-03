import Vapor
import ResendKit

extension Application {
    public struct Resend {
        private final class Storage {
            let apiKey: String
            
            init(apiKey: String) {
                self.apiKey = apiKey
            }
        }

        private struct Key: StorageKey {
            typealias Value = Storage
        }

        private var storage: Storage {
            if self.application.storage[Key.self] == nil {
                self.initialize()
            }
            return self.application.storage[Key.self]!
        }
        
        public func initialize() {
            guard let apiKey = Environment.process.RESEND_API_KEY else {
                fatalError("No resend API key provided")
            }
            
            self.application.storage[Key.self] = .init(apiKey: apiKey)
            ResendClient.initialized(httpClient: self.application.http.client.shared, apiKey: self.storage.apiKey)
        }

        fileprivate let application: Application

        public var client: ResendClient {
            .init(httpClient: self.application.http.client.shared, apiKey: self.storage.apiKey)
        }
    }

    public var resend: Resend { .init(application: self) }
}

public extension Application.Resend {
    static var email = ResendClient.email
    static var domain = ResendClient.domains
}
